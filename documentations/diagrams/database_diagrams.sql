CREATE TABLE "users" (
  "id" integer,
  "email" varchar,
  "password" varchar,
  "created_at" timestamp,
  "updated_at" timestamp,
  "token" varchar
);

CREATE TABLE "products" (
  "id" integer,
  "title" varchar,
  "description" text,
  "user_id" integer,
  "quantity" integer,
  "published" boolean DEFAULT true
);

CREATE TABLE "orders" (
  "id" integer,
  "user_id" integer,
  "total" decimal
);

CREATE TABLE "placements" (
  "id" integer,
  "order_id" integer,
  "product_id" integer,
  "quantity" integer
);

CREATE INDEX "user_token" ON "users" ("token");

CREATE INDEX "products_user" ON "products" ("user_id");

ALTER TABLE "orders" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "placements" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("id") REFERENCES "placements" ("product_id");
