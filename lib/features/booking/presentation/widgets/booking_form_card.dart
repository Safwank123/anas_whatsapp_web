import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../core/app_colors.dart';
import '../../../../shared/responsive.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../data/booking_repository.dart';
import '../../data/whatsapp_launcher.dart';
import '../../domain/booking_request.dart';

class BookingFormCard extends StatefulWidget {
  const BookingFormCard({super.key});

  @override
  State<BookingFormCard> createState() => _BookingFormCardState();
}

class _BookingFormCardState extends State<BookingFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _repository = BookingRepository();
  final _whatsApp = const WhatsAppLauncher();

  DateTime? _checkIn;
  DateTime? _checkOut;
  int _adults = 2;
  int _children = 0;
  int _belowFive = 0;
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isCheckIn}) async {
    final today = DateTime.now();
    final firstDate = isCheckIn ? today : (_checkIn ?? today);
    final initialDate = isCheckIn
        ? (_checkIn ?? today)
        : (_checkOut ?? firstDate.add(const Duration(days: 1)));

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(firstDate) ? firstDate : initialDate,
      firstDate: firstDate,
      lastDate: today.add(const Duration(days: 730)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.forest,
                  secondary: AppColors.gold,
                ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    setState(() {
      if (isCheckIn) {
        _checkIn = picked;
        if (_checkOut != null && !_checkOut!.isAfter(picked)) {
          _checkOut = picked.add(const Duration(days: 1));
        }
      } else {
        _checkOut = picked;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_checkIn == null || _checkOut == null) {
      _showMessage('Please select check-in and check-out dates.');
      return;
    }
    if (!_checkOut!.isAfter(_checkIn!)) {
      _showMessage('Check-out must be after check-in.');
      return;
    }

    setState(() => _loading = true);

    final request = BookingRequest(
      name: _nameController.text.trim(),
      checkIn: _checkIn!,
      checkOut: _checkOut!,
      adults: _adults,
      children: _children,
      belowFive: _belowFive,
    );

    try {
      await _repository.save(request);
      await _whatsApp.openBookingChat(request);
      _showMessage('Booking enquiry saved. WhatsApp is opening now.');
    } on FirebaseNotConfiguredException {
      _showMessage(
        'Firebase is not ready yet. WhatsApp is opening with your enquiry.',
      );
      await _whatsApp.openBookingChat(request);
    } catch (_) {
      _showMessage('We could not complete the request. Please try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);

    return GlassCard(
      padding: EdgeInsets.all(mobile ? 20 : 28),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Reserve your stay',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: mobile ? 28 : 32,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              Firebase.apps.isNotEmpty
                  ? 'Tell us your dates and guest count.'
                  : 'WhatsApp opens after submit. Firebase is not ready yet.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.charcoal.withValues(alpha: 0.68),
                    height: 1.45,
                  ),
            ),
            const SizedBox(height: 22),
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.trim().length < 2) {
                  return 'Enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            _DateField(
              label: 'Check in date',
              value: _checkIn,
              onTap: () => _pickDate(isCheckIn: true),
            ),
            const SizedBox(height: 14),
            _DateField(
              label: 'Check out date',
              value: _checkOut,
              onTap: () => _pickDate(isCheckIn: false),
            ),
            const SizedBox(height: 14),
            _GuestSelector(
              label: 'Adult (12 yr above)',
              value: _adults,
              min: 1,
              onChanged: (value) => setState(() => _adults = value),
            ),
            const SizedBox(height: 14),
            _GuestSelector(
              label: 'Child (6-12 yr)',
              value: _children,
              onChanged: (value) => setState(() => _children = value),
            ),
            const SizedBox(height: 14),
            _GuestSelector(
              label: 'Below 5 yr',
              value: _belowFive,
              onChanged: (value) => setState(() => _belowFive = value),
            ),
            const SizedBox(height: 22),
            _SubmitButton(loading: _loading, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today_outlined),
        ),
        child: Text(
          value == null ? 'Select date' : _formatDate(value!),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: value == null
                    ? AppColors.charcoal.withValues(alpha: 0.45)
                    : AppColors.charcoal,
              ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}

class _GuestSelector extends StatelessWidget {
  const _GuestSelector({
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
  });

  final String label;
  final int value;
  final int min;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.group_outlined),
      ),
      items: [
        for (var count = min; count <= 10; count++)
          DropdownMenuItem(value: count, child: Text('$count')),
      ],
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton({required this.loading, required this.onPressed});

  final bool loading;
  final VoidCallback onPressed;

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered && !widget.loading ? 1.02 : 1,
        duration: const Duration(milliseconds: 180),
        child: SizedBox(
          width: double.infinity,
          height: 58,
          child: FilledButton(
            onPressed: widget.loading ? null : widget.onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.forest,
              disabledBackgroundColor: AppColors.moss,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 0,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: widget.loading
                  ? const SizedBox(
                      key: ValueKey('loading'),
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : const Row(
                      key: ValueKey('label'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit booking enquiry',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_rounded),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
