DO $$
BEGIN
    IF (SELECT COUNT(*) FROM public.baza) <> 3 THEN
        RAISE EXCEPTION 'FAIL: oczekiwano 3 rekordów w tabeli baza';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM (
            VALUES
                (1, 'Pierwszy wpis', 'Dane testowe aplikacji Flask.',
                 TIMESTAMP '2026-01-01 10:00:00'),
                (2, 'Polskie znaki', 'Zażółć gęślą jaźń.',
                 TIMESTAMP '2026-01-02 11:30:00'),
                (3, 'Znaki specjalne', 'Apostrof: '' oraz symbole: <>&".',
                 TIMESTAMP '2026-01-03 12:45:00')
        ) AS expected(id, title, content, created_at)
        LEFT JOIN public.baza AS actual
            ON actual.id = expected.id
        WHERE actual.id IS NULL
           OR actual.title IS DISTINCT FROM expected.title
           OR actual.content IS DISTINCT FROM expected.content
           OR actual.created_at IS DISTINCT FROM expected.created_at
    ) THEN
        RAISE EXCEPTION 'FAIL: zawartość tabeli baza jest niezgodna';
    END IF;

    RAISE NOTICE 'PASS: liczba rekordów i wszystkie wartości są poprawne';
END
$$;