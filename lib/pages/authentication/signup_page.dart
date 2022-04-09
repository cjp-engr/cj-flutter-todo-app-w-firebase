import 'package:first_bloc/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:validators/validators.dart';

import '../../utils/error_dialog.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = '/signup';

  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _passwordController = TextEditingController();
  String? _name, _email, _password;
  late RiveAnimationController _controller1;

  //void _togglePlay() => _controller.isActive = !_controller.isActive;

  @override
  void initState() {
    super.initState();
    _controller1 = OneShotAnimation('idle');
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
      _controller1.isActive = false;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      _controller1.isActive = true;
      return;
    }

    form.save();

    print('name: $_name, email: $_email, password: $_password');

    context.read<SignupCubit>().signup(
          name: _name!,
          email: _email!,
          password: _password!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.signupStatus == SignupStatus.error) {
            print('signup error');
            _controller1.isActive = true;
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: ListView(
                    shrinkWrap: true,
                    reverse: true,
                    children: [
                      Container(
                        child: RiveAnimation.asset(
                          'assets/images/animated_login_screen.riv',
                          animations: ['success'],
                          fit: BoxFit.cover,
                          controllers: [_controller1],
                        ),
                        width: double.infinity,
                        height: 300,
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.account_box),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name required';
                          }
                          if (value.trim().length < 2) {
                            return 'Name must be at least 2 characters';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _name = value;
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email required';
                          }
                          if (!isEmail(value.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _email = value;
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password required';
                          }
                          if (value.trim().length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _password = value;
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (String? value) {
                          if (_passwordController.text != value) {
                            return 'Passwords not match';
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: state.signupStatus == SignupStatus.submitting
                            ? null
                            : _submit,
                        child: Text(
                          state.signupStatus == SignupStatus.submitting
                              ? 'Loading...'
                              : 'Sign Up',
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed: state.signupStatus == SignupStatus.submitting
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                        child: const Text('Already a member? Sign in!'),
                      ),
                    ].reversed.toList(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
