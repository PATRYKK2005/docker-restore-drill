BEGIN;

TRUNCATE TABLE public.baza RESTART IDENTITY;

INSERT INTO public.baza (title, content, created_at)
VALUES
    ('Pierwszy wpis', 'Dane testowe aplikacji Flask.',
     TIMESTAMP '2026-01-01 10:00:00'),
    ('Polskie znaki', 'Zażółć gęślą jaźń.',
     TIMESTAMP '2026-01-02 11:30:00'),
    ('Znaki specjalne', 'Apostrof: '' oraz symbole: <>&".',
     TIMESTAMP '2026-01-03 12:45:00');

COMMIT;