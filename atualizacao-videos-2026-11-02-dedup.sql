-- ============================================================================
-- O insert dos 3 vídeos novos (Sam's Club, KMV Ipiranga, One Sec) acabou
-- rodando 2 vezes, duplicando as linhas. Isso remove a duplicata de cada um,
-- mantendo só a linha mais antiga (id menor).
--
-- Supabase > SQL Editor > New query > cola tudo > Run.
-- ============================================================================

delete from public.videos_geral a
using public.videos_geral b
where a.video_id = b.video_id
  and a.video_id in ('utRhC5mvcTo', 'd_b6BFjK9Nk', 'J258kXIPTQw')
  and a.id > b.id;
