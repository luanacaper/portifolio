-- ============================================================================
-- Ajuste 28/10/2026: o "Tekoá 03 – Anúncio (ROAS 7,20)" nunca foi um vídeo
-- separado — é o mesmo vídeo já publicado como "Tekoá 05 – Anúncio" (legenda
-- "sempre", prato com paninho rosa). Remove o duplicado e marca a nota certa
-- no que já existe.
--
-- Supabase > SQL Editor > New query > cola tudo > Run.
-- ============================================================================

delete from public.videos_geral where titulo = 'Tekoá 03 – Anúncio' and nota = 'ROAS 7,20';
update public.videos_geral set nota = 'ROAS 7,20' where titulo = 'Tekoá 05 – Anúncio';
