drop extension if exists "pg_net";


  create table "public"."businesses" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "name" text not null,
    "address" text not null,
    "place_id" text not null,
    "latitude" double precision not null,
    "longitude" double precision not null,
    "primary_category" text,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."businesses" enable row level security;


  create table "public"."keyword_rank_results" (
    "id" uuid not null default gen_random_uuid(),
    "rank_scan_id" uuid not null,
    "keyword_id" uuid not null,
    "rank_position" integer,
    "found" boolean not null default false,
    "source" text not null default 'places'::text,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."keyword_rank_results" enable row level security;


  create table "public"."keywords" (
    "id" uuid not null default gen_random_uuid(),
    "business_id" uuid not null,
    "keyword" text not null,
    "is_active" boolean default true,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."keywords" enable row level security;


  create table "public"."rank_scans" (
    "id" uuid not null default gen_random_uuid(),
    "business_id" uuid not null,
    "scan_type" text not null,
    "radius_meters" integer not null default 3000,
    "status" text not null default 'pending'::text,
    "queries_consumed" integer not null default 0,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."rank_scans" enable row level security;


  create table "public"."user_quotas" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "month" date not null,
    "queries_allowed" integer not null,
    "queries_used" integer not null default 0,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."user_quotas" enable row level security;

CREATE UNIQUE INDEX businesses_pkey ON public.businesses USING btree (id);

CREATE INDEX idx_businesses_user_id ON public.businesses USING btree (user_id);

CREATE INDEX idx_keywords_business_id ON public.keywords USING btree (business_id);

CREATE INDEX idx_rank_scans_business_id ON public.rank_scans USING btree (business_id);

CREATE INDEX idx_rank_scans_created_at ON public.rank_scans USING btree (created_at DESC);

CREATE INDEX idx_results_keyword_id ON public.keyword_rank_results USING btree (keyword_id);

CREATE INDEX idx_results_rank_scan_id ON public.keyword_rank_results USING btree (rank_scan_id);

CREATE INDEX idx_user_quotas_user_month ON public.user_quotas USING btree (user_id, month);

CREATE UNIQUE INDEX keyword_rank_results_pkey ON public.keyword_rank_results USING btree (id);

CREATE UNIQUE INDEX keywords_pkey ON public.keywords USING btree (id);

CREATE UNIQUE INDEX rank_scans_pkey ON public.rank_scans USING btree (id);

CREATE UNIQUE INDEX user_quotas_pkey ON public.user_quotas USING btree (id);

CREATE UNIQUE INDEX user_quotas_user_id_month_key ON public.user_quotas USING btree (user_id, month);

alter table "public"."businesses" add constraint "businesses_pkey" PRIMARY KEY using index "businesses_pkey";

alter table "public"."keyword_rank_results" add constraint "keyword_rank_results_pkey" PRIMARY KEY using index "keyword_rank_results_pkey";

alter table "public"."keywords" add constraint "keywords_pkey" PRIMARY KEY using index "keywords_pkey";

alter table "public"."rank_scans" add constraint "rank_scans_pkey" PRIMARY KEY using index "rank_scans_pkey";

alter table "public"."user_quotas" add constraint "user_quotas_pkey" PRIMARY KEY using index "user_quotas_pkey";

alter table "public"."businesses" add constraint "businesses_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."businesses" validate constraint "businesses_user_id_fkey";

alter table "public"."keyword_rank_results" add constraint "keyword_rank_results_keyword_id_fkey" FOREIGN KEY (keyword_id) REFERENCES public.keywords(id) ON DELETE CASCADE not valid;

alter table "public"."keyword_rank_results" validate constraint "keyword_rank_results_keyword_id_fkey";

alter table "public"."keyword_rank_results" add constraint "keyword_rank_results_rank_scan_id_fkey" FOREIGN KEY (rank_scan_id) REFERENCES public.rank_scans(id) ON DELETE CASCADE not valid;

alter table "public"."keyword_rank_results" validate constraint "keyword_rank_results_rank_scan_id_fkey";

alter table "public"."keywords" add constraint "keywords_business_id_fkey" FOREIGN KEY (business_id) REFERENCES public.businesses(id) ON DELETE CASCADE not valid;

alter table "public"."keywords" validate constraint "keywords_business_id_fkey";

alter table "public"."rank_scans" add constraint "rank_scans_business_id_fkey" FOREIGN KEY (business_id) REFERENCES public.businesses(id) ON DELETE CASCADE not valid;

alter table "public"."rank_scans" validate constraint "rank_scans_business_id_fkey";

alter table "public"."rank_scans" add constraint "scan_status_check" CHECK ((status = ANY (ARRAY['pending'::text, 'complete'::text, 'failed'::text]))) not valid;

alter table "public"."rank_scans" validate constraint "scan_status_check";

alter table "public"."user_quotas" add constraint "user_quotas_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."user_quotas" validate constraint "user_quotas_user_id_fkey";

alter table "public"."user_quotas" add constraint "user_quotas_user_id_month_key" UNIQUE using index "user_quotas_user_id_month_key";

grant delete on table "public"."businesses" to "anon";

grant insert on table "public"."businesses" to "anon";

grant references on table "public"."businesses" to "anon";

grant select on table "public"."businesses" to "anon";

grant trigger on table "public"."businesses" to "anon";

grant truncate on table "public"."businesses" to "anon";

grant update on table "public"."businesses" to "anon";

grant delete on table "public"."businesses" to "authenticated";

grant insert on table "public"."businesses" to "authenticated";

grant references on table "public"."businesses" to "authenticated";

grant select on table "public"."businesses" to "authenticated";

grant trigger on table "public"."businesses" to "authenticated";

grant truncate on table "public"."businesses" to "authenticated";

grant update on table "public"."businesses" to "authenticated";

grant delete on table "public"."businesses" to "service_role";

grant insert on table "public"."businesses" to "service_role";

grant references on table "public"."businesses" to "service_role";

grant select on table "public"."businesses" to "service_role";

grant trigger on table "public"."businesses" to "service_role";

grant truncate on table "public"."businesses" to "service_role";

grant update on table "public"."businesses" to "service_role";

grant delete on table "public"."keyword_rank_results" to "anon";

grant insert on table "public"."keyword_rank_results" to "anon";

grant references on table "public"."keyword_rank_results" to "anon";

grant select on table "public"."keyword_rank_results" to "anon";

grant trigger on table "public"."keyword_rank_results" to "anon";

grant truncate on table "public"."keyword_rank_results" to "anon";

grant update on table "public"."keyword_rank_results" to "anon";

grant delete on table "public"."keyword_rank_results" to "authenticated";

grant insert on table "public"."keyword_rank_results" to "authenticated";

grant references on table "public"."keyword_rank_results" to "authenticated";

grant select on table "public"."keyword_rank_results" to "authenticated";

grant trigger on table "public"."keyword_rank_results" to "authenticated";

grant truncate on table "public"."keyword_rank_results" to "authenticated";

grant update on table "public"."keyword_rank_results" to "authenticated";

grant delete on table "public"."keyword_rank_results" to "service_role";

grant insert on table "public"."keyword_rank_results" to "service_role";

grant references on table "public"."keyword_rank_results" to "service_role";

grant select on table "public"."keyword_rank_results" to "service_role";

grant trigger on table "public"."keyword_rank_results" to "service_role";

grant truncate on table "public"."keyword_rank_results" to "service_role";

grant update on table "public"."keyword_rank_results" to "service_role";

grant delete on table "public"."keywords" to "anon";

grant insert on table "public"."keywords" to "anon";

grant references on table "public"."keywords" to "anon";

grant select on table "public"."keywords" to "anon";

grant trigger on table "public"."keywords" to "anon";

grant truncate on table "public"."keywords" to "anon";

grant update on table "public"."keywords" to "anon";

grant delete on table "public"."keywords" to "authenticated";

grant insert on table "public"."keywords" to "authenticated";

grant references on table "public"."keywords" to "authenticated";

grant select on table "public"."keywords" to "authenticated";

grant trigger on table "public"."keywords" to "authenticated";

grant truncate on table "public"."keywords" to "authenticated";

grant update on table "public"."keywords" to "authenticated";

grant delete on table "public"."keywords" to "service_role";

grant insert on table "public"."keywords" to "service_role";

grant references on table "public"."keywords" to "service_role";

grant select on table "public"."keywords" to "service_role";

grant trigger on table "public"."keywords" to "service_role";

grant truncate on table "public"."keywords" to "service_role";

grant update on table "public"."keywords" to "service_role";

grant delete on table "public"."rank_scans" to "anon";

grant insert on table "public"."rank_scans" to "anon";

grant references on table "public"."rank_scans" to "anon";

grant select on table "public"."rank_scans" to "anon";

grant trigger on table "public"."rank_scans" to "anon";

grant truncate on table "public"."rank_scans" to "anon";

grant update on table "public"."rank_scans" to "anon";

grant delete on table "public"."rank_scans" to "authenticated";

grant insert on table "public"."rank_scans" to "authenticated";

grant references on table "public"."rank_scans" to "authenticated";

grant select on table "public"."rank_scans" to "authenticated";

grant trigger on table "public"."rank_scans" to "authenticated";

grant truncate on table "public"."rank_scans" to "authenticated";

grant update on table "public"."rank_scans" to "authenticated";

grant delete on table "public"."rank_scans" to "service_role";

grant insert on table "public"."rank_scans" to "service_role";

grant references on table "public"."rank_scans" to "service_role";

grant select on table "public"."rank_scans" to "service_role";

grant trigger on table "public"."rank_scans" to "service_role";

grant truncate on table "public"."rank_scans" to "service_role";

grant update on table "public"."rank_scans" to "service_role";

grant delete on table "public"."user_quotas" to "anon";

grant insert on table "public"."user_quotas" to "anon";

grant references on table "public"."user_quotas" to "anon";

grant select on table "public"."user_quotas" to "anon";

grant trigger on table "public"."user_quotas" to "anon";

grant truncate on table "public"."user_quotas" to "anon";

grant update on table "public"."user_quotas" to "anon";

grant delete on table "public"."user_quotas" to "authenticated";

grant insert on table "public"."user_quotas" to "authenticated";

grant references on table "public"."user_quotas" to "authenticated";

grant select on table "public"."user_quotas" to "authenticated";

grant trigger on table "public"."user_quotas" to "authenticated";

grant truncate on table "public"."user_quotas" to "authenticated";

grant update on table "public"."user_quotas" to "authenticated";

grant delete on table "public"."user_quotas" to "service_role";

grant insert on table "public"."user_quotas" to "service_role";

grant references on table "public"."user_quotas" to "service_role";

grant select on table "public"."user_quotas" to "service_role";

grant trigger on table "public"."user_quotas" to "service_role";

grant truncate on table "public"."user_quotas" to "service_role";

grant update on table "public"."user_quotas" to "service_role";


  create policy "Users can manage their businesses"
  on "public"."businesses"
  as permissive
  for all
  to public
using ((user_id = auth.uid()))
with check ((user_id = auth.uid()));



  create policy "Users can access their keyword rank results"
  on "public"."keyword_rank_results"
  as permissive
  for all
  to public
using ((rank_scan_id IN ( SELECT rs.id
   FROM (public.rank_scans rs
     JOIN public.businesses b ON ((rs.business_id = b.id)))
  WHERE (b.user_id = auth.uid()))))
with check ((rank_scan_id IN ( SELECT rs.id
   FROM (public.rank_scans rs
     JOIN public.businesses b ON ((rs.business_id = b.id)))
  WHERE (b.user_id = auth.uid()))));



  create policy "Users can manage keywords for their businesses"
  on "public"."keywords"
  as permissive
  for all
  to public
using ((business_id IN ( SELECT businesses.id
   FROM public.businesses
  WHERE (businesses.user_id = auth.uid()))))
with check ((business_id IN ( SELECT businesses.id
   FROM public.businesses
  WHERE (businesses.user_id = auth.uid()))));



  create policy "Users can access their rank scans"
  on "public"."rank_scans"
  as permissive
  for all
  to public
using ((business_id IN ( SELECT businesses.id
   FROM public.businesses
  WHERE (businesses.user_id = auth.uid()))))
with check ((business_id IN ( SELECT businesses.id
   FROM public.businesses
  WHERE (businesses.user_id = auth.uid()))));



  create policy "Users can view their own quotas"
  on "public"."user_quotas"
  as permissive
  for select
  to public
using ((user_id = auth.uid()));



