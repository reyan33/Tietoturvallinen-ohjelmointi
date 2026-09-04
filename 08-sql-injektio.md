# Mitä tein?

Kokeilin SQL-injektiota tehtävän foorumin kirjautumissivulla.

Kirjoitin käyttäjänimikenttään:

`' OR '1'='1' -- `

Sen jälkeen kokeilin kirjautua sisään ilman oikeaa käyttäjänimeä ja salasanaa.

# Mitä sain aikaan?

SQL-injektio onnistui. Pääsin kirjautumaan foorumille ja sivulla näkyi:

`Tervetuloa Seppo Sikäläinen`

Eli pääsin sisään Seppo-käyttäjänä, vaikka en käyttänyt Sepon oikeaa salasanaa.

# Mitä pellin alla tapahtuu, miksi hyökkäys onnistui?

Kirjautumissivu tekee SQL-kyselyn käyttäjänimen ja salasanan perusteella.

Kun kirjoitin `' OR '1'='1' -- `, syöte muutti SQL-kyselyn ehtoa.

`1=1` on aina totta ja `--` kommentoi kyselyn loppuosan pois.

Tämän takia salasanaa ei tarkistettu normaalisti ja pääsin kirjautumaan sisään.
