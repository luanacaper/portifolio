-- ============================================================================
-- 3 vídeos novos na categoria Tech, Apps & Infoprodutos (31/10/2026), inseridos
-- com "ordem" menor que os já existentes nessa categoria (App Place=120,
-- Ana Neves=210) pra aparecerem primeiro dentro dela.
--
-- A ordem das categorias na página (Tech primeiro, logo abaixo de "Os melhores
-- resultados") é definida no código (NICHOS), não no banco — já ajustei lá.
--
-- Supabase > SQL Editor > New query > cola tudo > Run.
-- ============================================================================

insert into public.videos_geral (titulo, marca, nicho, plataforma, video_id, ordem, publicado) values
  ('Sam''s Club',   'Sam''s Club',   'tech-infoprodutos', 'yt', 'utRhC5mvcTo', 100, true),
  ('KMV Ipiranga',  'KMV Ipiranga',  'tech-infoprodutos', 'yt', 'd_b6BFjK9Nk', 101, true),
  ('One Sec',       'One Sec',       'tech-infoprodutos', 'yt', 'J258kXIPTQw', 102, true);
