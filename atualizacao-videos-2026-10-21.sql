-- ============================================================================
-- Vídeos novos que a Luana mandou em 21/10/2026: preenche o link (video_id) de
-- vídeos que já existiam como "em breve" no catálogo, adiciona 1 vídeo novo
-- (Blant Cosméticos), corrige os títulos dos 2 vídeos da Milkmoo (os dois são
-- orgânico) e remove a Ambrô do portfólio (vídeo + logo no ticker de marcas).
--
-- Supabase > SQL Editor > New query > cola tudo > Run.
-- ============================================================================

update public.videos_geral set plataforma = 'yt', video_id = 'ud_zfmstncQ'
  where titulo = 'Tekoá 01 – Anúncio';

update public.videos_geral set plataforma = 'yt', video_id = 'aOpO3Kbo53Q'
  where titulo = 'App Place (versão original)';

update public.videos_geral set plataforma = 'yt', video_id = '0en9l-o3EOY', nota = 'Airfryer Philco'
  where titulo = 'Magalu 01';

update public.videos_geral set plataforma = 'yt', video_id = 'SDSJ_uolCiQ', nota = 'Airfryer Philco'
  where titulo = 'Magalu 02';

-- Os 2 vídeos da Milkmoo são orgânicos (ela confirmou) — renomeando o 2º, que
-- tinha ficado com título "Anúncio" por engano.
update public.videos_geral set plataforma = 'yt', video_id = 'f7GobRuUZLg', titulo = 'MilkMoo – Orgânico 1'
  where titulo = 'MilkMoo – Orgânico';

update public.videos_geral set plataforma = 'yt', video_id = '7Tvn9KKroxw', titulo = 'MilkMoo – Orgânico 2'
  where titulo = 'MilkMoo – Anúncio';

update public.videos_geral set plataforma = 'yt', video_id = 'LFxDQs0DlIk'
  where titulo = 'Block Carbo';

-- Café: só renomeei a marca pra "Nosso Café" (mais específico); ela não mandou link
-- novo pra esse, continua "em breve".
update public.videos_geral set marca = 'Nosso Café', nota = 'Goiânia'
  where titulo = 'Café';

-- Vídeo novo (não existia no catálogo ainda)
insert into public.videos_geral (titulo, marca, nicho, plataforma, video_id, ordem, publicado)
select 'Blant Cosméticos – Blindagem das unhas', 'Blant Cosméticos', 'beleza-saude', 'yt', '4wv-lsmlnJ4',
  coalesce((select max(ordem) from public.videos_geral), 0) + 1, true
where not exists (select 1 from public.videos_geral where titulo = 'Blant Cosméticos – Blindagem das unhas');

-- Ambrô: remover do portfólio (vídeo nunca teve link, e a marca saiu do ticker de logos)
delete from public.videos_geral where titulo = 'Unboxing Ambro';
delete from public.marcas_logos where nome = 'Ambrô';
