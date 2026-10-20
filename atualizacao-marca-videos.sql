-- ============================================================================
-- Só rode este arquivo se você JÁ rodou o "migracao-painel-geral.sql" antes
-- (ou seja, se a tabela videos_geral já existe no seu Supabase).
-- Se ainda não rodou nada, ignore este arquivo: o migracao-painel-geral.sql
-- já foi atualizado com a coluna "marca" certinha.
--
-- Adiciona a coluna "marca" (o nome que aparece em destaque na miniatura do
-- vídeo, pro público) e preenche com o valor de cada vídeo que já existe.
--
-- Supabase > SQL Editor > New query > cola tudo > Run.
-- ============================================================================

alter table public.videos_geral add column if not exists marca text;

update public.videos_geral set marca = 'Tekoá' where titulo like 'Tekoá%';
update public.videos_geral set marca = 'App Place' where titulo = 'App Place (versão original)';
update public.videos_geral set marca = 'Pressfit' where titulo = 'Cinta Press Fitness';
update public.videos_geral set marca = 'Ambrô' where titulo = 'Unboxing Ambro';
update public.videos_geral set marca = 'Casa de Gê' where titulo = 'Casa da Gê – Orgânico';
update public.videos_geral set marca = 'Shopee' where titulo = 'Achadinho da Shopee';
update public.videos_geral set marca = 'Magalu' where titulo like 'Magalu%';
update public.videos_geral set marca = 'Lola Cosmetics' where titulo = 'Bendita Ghee Lola';
update public.videos_geral set marca = 'Forever Liss' where titulo = 'Forever Liss';
update public.videos_geral set marca = 'Ana Neves' where titulo = 'Infoproduto Ana Neves';
update public.videos_geral set marca = 'Milky Moo' where titulo like 'MilkMoo%';
update public.videos_geral set marca = 'Café' where titulo = 'Café';
update public.videos_geral set marca = 'Block Carbo' where titulo = 'Block Carbo';
update public.videos_geral set marca = 'Aniversário do meu pai' where titulo = 'Viagem: aniversário do meu pai';
-- vídeos de viagem: marca igual ao título (nome do lugar)
update public.videos_geral set marca = titulo where nicho = 'viagem' and marca is null;

-- se sobrou algum sem marca (vídeo que você criou pelo painel depois da migração
-- original e ainda não tinha essa coluna), usa o próprio título como marca:
update public.videos_geral set marca = titulo where marca is null;

alter table public.videos_geral alter column marca set not null;
