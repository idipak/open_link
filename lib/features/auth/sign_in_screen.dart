import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          context.go('/home');
        } else if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Login failed')),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 34, 28, 30),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Logo & Brand
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: const Icon(
                                  Icons.menu_book_rounded,
                                  color: Colors.white,
                                  size: 17,
                                ),
                              ),
                              const SizedBox(width: 9),
                              Text(
                                'Open Link',
                                style: AppTextStyles.sans.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  letterSpacing: -0.01,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 54),

                          // Headline
                          Text(
                            'Remember\nwhat you read.',
                            style: AppTextStyles.editorialHeadline
                                .copyWith(fontSize: 36),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Save any article. We summarize it and quiz you so it actually sticks.',
                            style: AppTextStyles.sans.copyWith(
                              fontSize: 15,
                              color: AppColors.subtleText,
                              height: 1.4,
                            ),
                          ),

                          const Spacer(),

                          // Google Sign-In
                          AppButton(
                            text: 'Continue with Google',
                            variant: AppButtonVariant.outline,
                            icon: const Icon(Icons.g_mobiledata_rounded,
                                color: AppColors.accent, size: 22),
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(const GoogleSignInRequested());
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                const Expanded(
                                    child:
                                        Divider(color: AppColors.dividerAlt)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text(
                                    'or',
                                    style: AppTextStyles.sans.copyWith(
                                      fontSize: 12,
                                      color: AppColors.mutedText,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                    child:
                                        Divider(color: AppColors.dividerAlt)),
                              ],
                            ),
                          ),

                          AppTextField(
                            label: 'Email address',
                            hintText: 'you@example.com',
                            controller: _emailController,
                          ),
                          const SizedBox(height: 12),
                          AppTextField(
                            label: 'Password',
                            hintText: '••••••••',
                            isPassword: true,
                            controller: _passwordController,
                          ),

                          const SizedBox(height: 16),

                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state.status == AuthStatus.loading) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: CircularProgressIndicator(
                                      color: AppColors.accent,
                                    ),
                                  ),
                                );
                              }
                              return AppButton(
                                text: 'Log in',
                                onPressed: () {
                                  context.read<AuthBloc>().add(LoginSubmitted(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ));
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 24),

                          Center(
                            child: RichText(
                              text: TextSpan(
                                style: AppTextStyles.sans.copyWith(
                                  fontSize: 14,
                                  color: AppColors.subtleText,
                                ),
                                children: [
                                  const TextSpan(text: 'New here? '),
                                  TextSpan(
                                    text: 'Create account',
                                    style: AppTextStyles.sans.copyWith(
                                      color: AppColors.accent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
