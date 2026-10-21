-- ============================================================================
-- Ajustes pedidos em 22/10/2026:
-- - Remove "Pousada Aimê" da aba Viagem do catálogo.
-- - Remove "Viagem: aniversário do meu pai" (era duplicado — o vídeo já existe
--   como "Casa Cachoeira Sonho Meu", que já tem link).
--
-- Supabase > SQL Editor > New query > cola tudo > Run.
-- ============================================================================

delete from public.videos_geral where titulo = 'Pousada Aimê';
delete from public.videos_geral where titulo = 'Viagem: aniversário do meu pai';
