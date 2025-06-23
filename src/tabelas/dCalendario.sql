/*dCalendario*/
/*-----------------------------------------------------*/
dCalendario = ADDCOLUMNS(
    CALENDARAUTO(),
    "Ano", YEAR([Date]),
    "Semestre", IF(MONTH([Date]) <= 6, 1, 2),
    "Trimestre", QUARTER([Date]),
    "Mes", MONTH([Date]),
    "Mes Nome", 
        VAR vNomeMes = FORMAT([Date], "mmmm")
        VAR vPriMaiuscula = UPPER(vNomeMes)
        VAR vPriLetra = LEFT(vPriMaiuscula, 1)
        VAR vDemaisMinusculas = MID(vNomeMes, 2, 12)
        VAR vResultado = TRIM(vPriLetra & vDemaisMinusculas)
        RETURN
            vResultado,
    "Mes Nome Abreviado", 
        VAR vNomeMes = FORMAT([Date], "mmm")
        VAR vPriMaiuscula = UPPER(vNomeMes)
        VAR vPriLetra = LEFT(vPriMaiuscula, 1)
        VAR vDemaisMinusculas = MID(vNomeMes, 2, 2)
        VAR vResultado = TRIM(vPriLetra & vDemaisMinusculas)
        RETURN
            vResultado,
    "Mes Ano", 
        VAR vNomeMes =  FORMAT([Date], "mmm/yyyy")
        VAR vPriMaiuscula = UPPER(vNomeMes)
        VAR vPriLetra = LEFT(vPriMaiuscula, 1)
        VAR vDemaisMinusculas = MID(vNomeMes, 2, 7)
        VAR vResultado = TRIM(vPriLetra & vDemaisMinusculas)
        RETURN
            vResultado,
    "Semana", WEEKNUM([Date]),
    "Dia", Day([Date]),
    "Dia Nome Abreviado", 
        VAR vNomeDia = FORMAT([Date], "ddd")
        VAR vPriMaiuscula = UPPER(vNomeDia)
        VAR vPriLetra = LEFT(vPriMaiuscula, 1)
        VAR vDemaisMinusculas = MID(vNomeDia, 2, 2)
        VAR vResultado = TRIM(vPriLetra & vDemaisMinusculas)
        RETURN
            vResultado,
    "Dia Nome Classificacao", WEEKDAY([Date]),
    "Mes Ano Classificacao", INT(FORMAT([Date], "yyyymm")) --coluna numérica para classificar "Mes-Ano"
)