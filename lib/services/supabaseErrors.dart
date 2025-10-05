// lib/utils/supabase_errors.dart

/// Lista de padrões de erro do Supabase -> português.
/// Use `contains` para garantir robustez contra variações.
final List<Map<String, String>> _supabaseErrorMap = [
  {
    "match": "Password should be at least 6 characters",
    "pt": "A senha deve ter no mínimo 6 caracteres.",
  },
  {"match": "Invalid login credentials", "pt": "Credenciais inválidas."},
  {
    "match": "Email not confirmed",
    "pt": "E-mail ainda não confirmado. Verifique sua caixa de entrada.",
  },
  {
    "match": "Email rate limit exceeded",
    "pt": "Muitas tentativas. Tente novamente mais tarde.",
  },
  {"match": "User already registered", "pt": "Este e-mail já está cadastrado."},
  {
    "match": "Signup disabled",
    "pt": "Cadastro de novos usuários está desativado.",
  },
  {"match": "User not found", "pt": "Usuário não encontrado."},
  {
    "match": "Token has expired",
    "pt": "Seu link/token expirou. Solicite um novo.",
  },
  {"match": "Invalid or expired otp", "pt": "Código inválido ou expirado."},
  {"match": "Invalid email", "pt": "Informe um e-mail válido."},
  {"match": "Password cannot be empty", "pt": "Informe uma senha."},
  {"match": "Forbidden", "pt": "Acesso negado."},
  {"match": "Unauthorized", "pt": "Não autorizado."},
  {"match": "Bad Request", "pt": "Requisição inválida."},
  {
    "match": "Service temporarily unavailable",
    "pt": "Serviço temporariamente indisponível. Tente novamente em instantes.",
  },
];

/// Função que traduz mensagens do Supabase para português
String traduzirSupabaseErro(Object? err) {
  final raw = err?.toString() ?? '';
  if (raw.isEmpty) return "Ocorreu um erro inesperado.";
  final msg = raw.toLowerCase();
  for (final m in _supabaseErrorMap) {
    final pat = (m["match"] ?? "").toLowerCase();
    if (pat.isNotEmpty && msg.contains(pat)) {
      return m["pt"]!;
    }
  }
  return raw; // fallback: mostra a mensagem original
}
