import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool _loading = false;

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();

    if (otp.length < 6) {
      _showError('Enter valid OTP');
      return;
    }

    setState(() => _loading = true);

    try {
      await Supabase.instance.client.auth.verifyOTP(
        phone: widget.phone,
        token: otp,
        type: OtpType.sms,
      );

      // No navigation here
      // GoRouter auth guard will redirect automatically
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter OTP sent to ${widget.phone}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '6-digit code',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _verifyOtp,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
