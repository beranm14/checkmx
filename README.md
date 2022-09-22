# Checkmx repozitář se skripty pro listování domén s MX záznamy

Nejdříve stáhněte soubor `domain2multi-cz00.txt` z https://github.com/tb0hdan/domains

Následně protřiďte domény:

```
grep -o '[\-a-zA-Z0-9\-]*\.cz' domain2multi-cz00.txt > domains.txt
sort --parallel=32 domains.txt | uniq > domains_uniq.txt
```

Pro nalezení všech domén s MX záznamy:

```
parallel -j 32 ./check_mx.sh “{}” < domains_uniq.txt
```

Pro hledání google MX:

```
parallel -j 32 ./check_mx_google_domain.sh “{}” < domains_uniq.txt
```

Podobně pro outlook a seznam.

Pro kontrolu aktivity domén pak:

```
parallel -j 32 ./check_single_url.sh "{}" "outlook" < outlook_mx.txt
```

Pro google a seznam nahraďte outlook, tedy:

```
parallel -j 32 ./check_single_url.sh "{}" "seznam" < seznam_mx.txt
parallel -j 32 ./check_single_url.sh "{}" "google" < google_mx.txt
```

Počty domén zjistíte pomocí `wc -l ...txt`.
