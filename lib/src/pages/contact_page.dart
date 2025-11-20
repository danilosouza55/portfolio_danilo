import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_danilo/src/core/theme/app_colors.dart';
import 'package:portfolio_danilo/src/core/widgets/modern_components.dart';
import 'package:portfolio_danilo/src/core/ui/landing_page_icons_icons.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchEmail() async {
    final String subject = 'Contato: ${_nameController.text}';
    final String body =
        'Nome: ${_nameController.text}\nEmail: ${_emailController.text}\n\nMensagem:\n${_messageController.text}';
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'danilo.souza@hotmail.com',
      query:
          'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Não foi possível abrir o cliente de email'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Não foi possível abrir o link'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao abrir link: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      // Launch email client with pre-filled form data
      await _launchEmail();

      setState(() => _isSubmitting = false);

      // Clear form after sending
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile = sizingInformation.isMobile;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
              vertical: isMobile ? 40 : 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  title: 'Entre em Contato',
                  subtitle: 'Vamos conversar sobre seu próximo projeto',
                ),
                SizedBox(height: isMobile ? 40 : 60),

                // Contact Methods and Form
                if (isMobile) ...[
                  _buildContactForm(context),
                  SizedBox(height: isMobile ? 40 : 60),
                  _buildContactMethods(context),
                ] else ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: _buildContactMethods(context),
                      ),
                      SizedBox(width: isMobile ? 0 : 60),
                      Expanded(
                        flex: 1,
                        child: _buildContactForm(context),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Envie uma Mensagem',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 24),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'Seu nome completo',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'seu.email@example.com',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, insira um e-mail válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Message Field
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Mensagem',
                  prefixIcon: const Icon(Icons.message),
                  hintText: 'Digite sua mensagem aqui',
                  alignLabelWithHint: true,
                ),
                minLines: 5,
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma mensagem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit Button
              ModernButton(
                label: _isSubmitting ? 'Enviando...' : 'Enviar Mensagem',
                onPressed: _isSubmitting ? () {} : _handleSubmit,
                isGradient: true,
                icon: Icons.send,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactMethods(BuildContext context) {
    final contactMethods = [
      {
        'title': 'E-mail',
        'value': 'danilo.souza@hotmail.com',
        'icon': Icons.email,
        'url': 'mailto:danilo.souza@hotmail.com',
      },
      {
        'title': 'GitHub',
        'value': '@danilosouza55',
        'icon': LandingPageIcons.github,
        'url': 'https://github.com/danilosouza55',
      },
      {
        'title': 'LinkedIn',
        'value': 'Danilo Araújo de Souza',
        'icon': LandingPageIcons.linkedin,
        'url': 'https://linkedin.com/in/danilo-araújo-de-souza-081b7398',
      },
      {
        'title': 'Instagram',
        'value': '@danilo_asouza',
        'icon': LandingPageIcons.instagram,
        'url': 'https://www.instagram.com/danilo_asouza',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informações de Contato',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 24),
        ...contactMethods.map((method) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildContactMethodCard(context, method),
            )),
      ],
    );
  }

  Widget _buildContactMethodCard(
      BuildContext context, Map<String, dynamic> method) {
    return GlassCard(
      onTap: () => _launchURL(method['url']),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(method['icon'] as IconData, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method['title'],
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  method['value'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.primary,
            size: 20,
          ),
        ],
      ),
    );
  }
}
