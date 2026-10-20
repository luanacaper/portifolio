-- ============================================================================
-- Portfólio Geral <> Painel /login/ (Portfolio UGC)
-- Rode este script inteiro de uma vez no Supabase: Painel do projeto
-- (tzpjkbzkmaeyjiktmpie) > SQL Editor > New query > cola tudo > Run.
--
-- Cria 4 tabelas novas (videos_geral, marcas_logos, depoimentos_geral,
-- servicos_geral), já com as regras de acesso (RLS) no mesmo padrão das
-- tabelas que já existem (ex.: "videos"), e popula com o que já está
-- publicado hoje no site, pra nada se perder na migração.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1) VIDEOS_GERAL — catálogo por nicho da página geral (diferente da tabela
--    "videos", que é só do portfólio de viagem)
-- ---------------------------------------------------------------------------
create table if not exists public.videos_geral (
  id bigint generated always as identity primary key,
  titulo text not null,
  marca text not null,
  nota text,
  nicho text not null,
  plataforma text,
  video_id text,
  ordem integer not null default 0,
  publicado boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.videos_geral enable row level security;

create policy "publico le publicados" on public.videos_geral
  for select to anon, authenticated
  using (publicado = true);

create policy "admin tudo" on public.videos_geral
  for all to authenticated
  using (is_admin()) with check (is_admin());

grant select on public.videos_geral to anon, authenticated;
grant insert, update, delete on public.videos_geral to authenticated;

-- ---------------------------------------------------------------------------
-- 2) MARCAS_LOGOS — bolinhas do carrossel "Marcas que confiaram no meu
--    trabalho". "arquivo" é só o nome do arquivo (ex.: milky-moo.png); o site
--    já sabe que a pasta é img/marcas/. "tamanho" aceita: (vazio), pequeno
--    ou grande — controla o selo colorido atrás de logos claras/brancas.
--    Atenção: pra marca NOVA, além de cadastrar aqui, o arquivo da imagem
--    precisa ser colocado em img/marcas/ no site (isso ainda é manual).
-- ---------------------------------------------------------------------------
create table if not exists public.marcas_logos (
  id bigint generated always as identity primary key,
  nome text not null,
  arquivo text not null,
  fundo text,
  tamanho text,
  ordem integer not null default 0,
  publicado boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.marcas_logos enable row level security;

create policy "publico le publicados" on public.marcas_logos
  for select to anon, authenticated
  using (publicado = true);

create policy "admin tudo" on public.marcas_logos
  for all to authenticated
  using (is_admin()) with check (is_admin());

grant select on public.marcas_logos to anon, authenticated;
grant insert, update, delete on public.marcas_logos to authenticated;

-- ---------------------------------------------------------------------------
-- 3) DEPOIMENTOS_GERAL — seção "O que dizem sobre o trabalho"
-- ---------------------------------------------------------------------------
create table if not exists public.depoimentos_geral (
  id bigint generated always as identity primary key,
  marca text not null,
  texto text not null,
  ctx text,
  ordem integer not null default 0,
  publicado boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.depoimentos_geral enable row level security;

create policy "publico le publicados" on public.depoimentos_geral
  for select to anon, authenticated
  using (publicado = true);

create policy "admin tudo" on public.depoimentos_geral
  for all to authenticated
  using (is_admin()) with check (is_admin());

grant select on public.depoimentos_geral to anon, authenticated;
grant insert, update, delete on public.depoimentos_geral to authenticated;

-- ---------------------------------------------------------------------------
-- 4) SERVICOS_GERAL — seção "O que podemos criar juntos?"
-- ---------------------------------------------------------------------------
create table if not exists public.servicos_geral (
  id bigint generated always as identity primary key,
  titulo text not null,
  texto text not null,
  ordem integer not null default 0,
  publicado boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.servicos_geral enable row level security;

create policy "publico le publicados" on public.servicos_geral
  for select to anon, authenticated
  using (publicado = true);

create policy "admin tudo" on public.servicos_geral
  for all to authenticated
  using (is_admin()) with check (is_admin());

grant select on public.servicos_geral to anon, authenticated;
grant insert, update, delete on public.servicos_geral to authenticated;

-- ============================================================================
-- SEED — migra o que já está fixo no código do site hoje
-- ============================================================================

insert into public.videos_geral (titulo, marca, nota, nicho, plataforma, video_id, ordem) values
  ('Chalé Lua', 'Chalé Lua', null, 'viagem', 'yt', 'ARMfs907Fbw', 10),
  ('Flutuante Serra da Mesa', 'Flutuante Serra da Mesa', null, 'viagem', 'yt', 'nmZHI9Psc44', 20),
  ('Lajinha', 'Lajinha', null, 'viagem', 'yt', 'OAcfpc5pOr4', 30),
  ('Pousada Aimê', 'Pousada Aimê', null, 'viagem', 'yt', 'CnLIGnGYo_s', 40),
  ('Casa Cachoeira Sonho Meu', 'Casa Cachoeira Sonho Meu', null, 'viagem', 'yt', 'b49WhEAw0Sc', 50),
  ('Mirante do Ipê', 'Mirante do Ipê', null, 'viagem', 'yt', '5bYZJZyPr2g', 60),
  ('Tekoá 01 – Anúncio', 'Tekoá', 'versão crua disponível', 'gastronomia-assinaturas', null, null, 70),
  ('Tekoá 02 – Anúncio', 'Tekoá', 'ROAS 6,90', 'gastronomia-assinaturas', 'yt', '-MRT1kAlS00', 80),
  ('Tekoá 03 – Orgânico', 'Tekoá', null, 'gastronomia-assinaturas', 'yt', 'H73cFN3u548', 90),
  ('Tekoá 03 – Anúncio', 'Tekoá', 'ROAS 7,54', 'gastronomia-assinaturas', 'yt', 'DK6EsJaCXWo', 100),
  ('Tekoá 03 – Anúncio', 'Tekoá', 'ROAS 7,20', 'gastronomia-assinaturas', null, null, 110),
  ('Tekoá 05 – Anúncio', 'Tekoá', null, 'gastronomia-assinaturas', 'yt', '_p9r453wBb4', 115),
  ('App Place (versão original)', 'App Place', 'R$27.383 orgânico + R$6.082, ROAS 5,6', 'tech-infoprodutos', null, null, 120),
  ('Cinta Press Fitness', 'Pressfit', null, 'beleza-saude', 'yt', '5oyfMuKEP-A', 130),
  ('Unboxing Ambro', 'Ambrô', null, 'beleza-saude', null, null, 140),
  ('Casa da Gê – Orgânico', 'Casa de Gê', null, 'casa-decoracao', 'yt', 'Zimf7dAbZcw', 150),
  ('Achadinho da Shopee', 'Shopee', null, 'casa-decoracao', 'yt', '75YRk5h9hQY', 160),
  ('Magalu 01', 'Magalu', null, 'casa-decoracao', null, null, 170),
  ('Magalu 02', 'Magalu', null, 'casa-decoracao', null, null, 180),
  ('Bendita Ghee Lola', 'Lola Cosmetics', null, 'beleza-saude', 'yt', 'XSHE4IoIWj4', 190),
  ('Forever Liss', 'Forever Liss', null, 'beleza-saude', 'yt', 'S1Z4bVlxLhE', 200),
  ('Infoproduto Ana Neves', 'Ana Neves', null, 'tech-infoprodutos', 'yt', 'VLDEq3BO1lg', 210),
  ('MilkMoo – Orgânico', 'Milky Moo', 'até 50x mais alcance', 'gastronomia-assinaturas', null, null, 220),
  ('MilkMoo – Anúncio', 'Milky Moo', null, 'gastronomia-assinaturas', null, null, 230),
  ('Café', 'Café', null, 'gastronomia-assinaturas', null, null, 240),
  ('Block Carbo', 'Block Carbo', 'bem-estar e saúde', 'beleza-saude', null, null, 250),
  ('Viagem: aniversário do meu pai', 'Aniversário do meu pai', null, 'viagem', null, null, 260);

insert into public.marcas_logos (nome, arquivo, fundo, tamanho, ordem) values
  ('Aimê', 'aime.png', null, null, 10),
  ('Magalu', 'magalu.png', null, null, 20),
  ('Shopee', 'shopee.png', null, null, 30),
  ('Casa de Gê', 'casa-de-ge.png', null, null, 40),
  ('Ambrô', 'ambro.png', null, null, 50),
  ('Sam''s Club', 'sams-club.png', null, null, 60),
  ('Nold Pet', 'nold-pet.png', null, null, 70),
  ('Fast Escova', 'fast-escova.png', null, null, 80),
  ('Place Company', 'place-company.png', null, null, 90),
  ('Pressfit', 'pressfit.png', '#e8457f', null, 100),
  ('Lola Cosmetics', 'lola-cosmetics.png', null, null, 110),
  ('Forever Liss', 'forever-liss.png', null, null, 120),
  ('Milky Moo', 'milky-moo.png', null, null, 130),
  ('Stabile & Pessoa Advogados', 'stabile-pessoa.png', '#14130f', 'grande', 140),
  ('HF Consultoria', 'hf-consultoria.png', null, null, 150),
  ('Facilita', 'facilita.png', null, null, 160),
  ('Ouze Loja', 'ouze-loja.png', '#14130f', null, 170),
  ('Rocklin', 'rocklin.png', null, null, 180),
  ('BuzzLead', 'buzzlead.png', null, null, 190),
  ('Instituto Deândhela', 'instituto-deandhela.png', null, null, 200),
  ('Aldeia Multiétnica', 'aldeia-multietnica.png', null, null, 210),
  ('Feel.Good Shop Online', 'feelgood.png', null, null, 220),
  ('La''s Palmas', 'las-palmas.png', null, null, 230),
  ('Barba Men', 'barba-men.png', '#2f7a73', null, 240),
  ('Eliefe', 'eliefe.png', null, null, 250),
  ('Zoe', 'zoe.png', '#13123a', null, 260),
  ('MaGê', 'mage.png', null, null, 270),
  ('UniAraguaia', 'uniaraguaia.png', null, null, 280),
  ('Cílios Showroom', 'cilios-showroom.png', null, null, 290),
  ('BioCenter', 'biocenter.png', null, null, 300),
  ('Indeniza Voo', 'indeniza-voo.png', null, null, 310);

insert into public.depoimentos_geral (marca, texto, ctx, ordem) values
  ('Place Company', 'A Luana entregou um ROAS que a gente nunca tinha alcançado em tráfego — foi a primeira vez que vimos esse número, e virou o novo padrão pra gente.', 'Tráfego pago · recorde de ROAS', 10),
  ('Tekoá', 'Rodamos os criativos com a Luana e emplacamos os melhores números de ROAS que já tivemos em assinatura: 6,90, 7,20 e 7,54.', 'ROAS 6,90 · 7,20 · 7,54', 20),
  ('Milkmoo', 'Os vídeos entregaram 5 vezes mais resultado de forma orgânica no nosso perfil. A Luana entende como poucos o que faz o conteúdo performar.', '+5x de resultado orgânico', 30),
  ('Cinta Press', 'Amei o conteúdo porque ela falou de tudo que a gente queria mostrar sobre os benefícios da cinta. Ficou exatamente como a gente precisava.', 'Vídeo de produto', 40),
  ('Block Carbo', 'Amei o vídeo. Você é muito criativa e agora a gente tem um material rico pra divulgação.', 'Vídeo de produto', 50),
  ('Casa Cachoeira Sonho Meu', 'Aquele primeiro vídeo fechou nossa agenda de fim de ano até junho deste ano.', 'Vídeo de viagem', 60);

insert into public.servicos_geral (titulo, texto, ordem) values
  ('Criativos para tráfego', 'Ads otimizados para Meta, TikTok e YouTube, pensados para gerar o melhor resultado ao menor custo.', 10),
  ('Gestão em escala', 'Campanhas com vários creators (UGC, nano, micro e influenciadores), do briefing à entrega, pra escalar seu conteúdo sem dor de cabeça — seja para orgânico ou tráfego pago.', 20),
  ('UGC para E-commerce', 'Vídeos autênticos de produto pra sua loja vender todo dia, com a naturalidade de quem realmente usa.', 30),
  ('Fotos UGC', 'Imagens com a mesma naturalidade dos vídeos, prontas pra feed, site e anúncios estáticos que também precisam vender.', 40);
