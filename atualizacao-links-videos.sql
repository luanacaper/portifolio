-- ============================================================================
-- Só rode este arquivo se você JÁ rodou o "migracao-painel-geral.sql" antes
-- (ou seja, se a tabela videos_geral já existe no seu Supabase).
-- Se ainda não rodou nada, ignore este arquivo: o migracao-painel-geral.sql
-- já foi atualizado com esses mesmos links e o "Tekoá 05 – Anúncio" novo.
--
-- Supabase > SQL Editor > New query > cola tudo > Run.
-- ============================================================================

update public.videos_geral set plataforma = 'yt', video_id = '-MRT1kAlS00' where titulo = 'Tekoá 02 – Anúncio';
update public.videos_geral set plataforma = 'yt', video_id = 'H73cFN3u548' where titulo = 'Tekoá 03 – Orgânico';
update public.videos_geral set plataforma = 'yt', video_id = 'DK6EsJaCXWo' where titulo = 'Tekoá 03 – Anúncio' and nota = 'ROAS 7,54';
update public.videos_geral set plataforma = 'yt', video_id = '5oyfMuKEP-A' where titulo = 'Cinta Press Fitness';
update public.videos_geral set plataforma = 'yt', video_id = 'Zimf7dAbZcw' where titulo = 'Casa da Gê – Orgânico';
update public.videos_geral set plataforma = 'yt', video_id = '75YRk5h9hQY' where titulo = 'Achadinho da Shopee';
update public.videos_geral set plataforma = 'yt', video_id = 'XSHE4IoIWj4' where titulo = 'Bendita Ghee Lola';
update public.videos_geral set plataforma = 'yt', video_id = 'S1Z4bVlxLhE' where titulo = 'Forever Liss';
update public.videos_geral set plataforma = 'yt', video_id = 'VLDEq3BO1lg' where titulo = 'Infoproduto Ana Neves';

insert into public.videos_geral (titulo, nota, nicho, plataforma, video_id, ordem)
select 'Tekoá 05 – Anúncio', null, 'gastronomia-assinaturas', 'yt', '_p9r453wBb4', 115
where not exists (select 1 from public.videos_geral where titulo = 'Tekoá 05 – Anúncio');
