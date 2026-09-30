# lab01 — Развёртывание PostgreSQL и загрузка Olist

**Студент:** Родионова К.М., группа ИНБО-20-23

- **Версия PostgreSQL:** 16.x (заменить на свою, узнать: `psql --version`)
- **Способ развёртывания:** локальная установка (без Docker)
- **ОС:** macOS
- **Способ импорта:** `psql`, команда `\copy` (клиентский импорт CSV)
- **Схемы:** `olist` (исходные данные), `lab` (учебные изменяемые объекты)

## Фактическое число строк после загрузки

| Таблица | Строк |
|---|---|
| customers | 99 441 |
| geolocation | 1 000 163 |
| orders | 99 441 |
| order_items | 112 650 |
| order_payments | 103 886 |
| order_reviews | 99 224 |
| products | 32 951 |
| sellers | 3 095 |
| product_category_name_translation | 71 |

## Как воспроизвести

```bash
createdb olist
psql -d olist -f schema.sql      # создание таблиц
psql -d olist -f import.sql      # загрузка CSV
psql -d olist -f keys.sql        # добавление PK и FK
psql -d olist -f check.sql       # контрольные проверки