/*Faturamento LY*/
/*-----------------------------------------------------*/
Faturamento LY = 
VAR vUltimaDataComVenda = CALCULATE(
    MAX('fVendas'[Data Pedido]),
    ALLSELECTED('dCalendario')
)
VAR vTabela = FILTER(
    VALUES('dCalendario'[Date]),
    'dCalendario'[Date] <= vUltimaDataComVenda
)
RETURN
CALCULATE(
    [Faturamento],
    SAMEPERIODLASTYEAR(vTabela)
)

/*Faturamento MTD*/
/*-----------------------------------------------------*/
Faturamento MTD = CALCULATE(
    [Faturamento],
    DATESMTD('dCalendario'[Date])
)

/*Faturamento % YoY*/
/*-----------------------------------------------------*/
Faturamento % YoY = DIVIDE(
    [Faturamento] - [Faturamento LY],
    [Faturamento LY]
)

/*Faturamento % MoM*/
/*-----------------------------------------------------*/
Faturamento % MoM = 
VAR vUltimaDataComVenda = CALCULATE(
    MAX('fVendas'[Data Pedido]),
    ALLSELECTED('dCalendario')
)
VAR vTabela = FILTER(
    VALUES(dCalendario[Date]),
    'dCalendario'[Date] <= vUltimaDataComVenda
)
VAR vFaturamentoMoM = CALCULATE(
    [Faturamento],
    DATEADD(vTabela, -1, MONTH)
)
RETURN
DIVIDE(
    [Faturamento] - vFaturamentoMoM,
    vFaturamentoMoM
)

/*Faturamento Acumulado*/
/*-----------------------------------------------------*/
Faturamento Acumulado = 
VAR vUltimaDataComVenda = CALCULATE(
    MAX('fVendas'[Data Pedido]),
    ALLSELECTED('dCalendario')
)
VAR vTabela = FILTER(
    VALUES('dCalendario'[Date]),
    'dCalendario'[Date] <= vUltimaDataComVenda
)
RETURN
CALCULATE(
    [Faturamento],
    DATESYTD(vTabela)
)

/*Faturamento Acumulado MTD*/
/*-----------------------------------------------------*/
Faturamento Acumulado MTD = 
VAR vUltimaDataComVenda = CALCULATE(
    MAX('fVendas'[Data Pedido]),
    ALLSELECTED('dCalendario')
)
VAR vTabela = FILTER(
    VALUES('dCalendario'[Date]),
    'dCalendario'[Date] <= vUltimaDataComVenda
)
RETURN
CALCULATE(
    [Faturamento],
    DATESMTD(vTabela)
)

/*Faturamento Acumulado YTD LY*/
/*-----------------------------------------------------*/
Faturamento Acumulado YTD LY = 
VAR vUltimaDataComVenda = CALCULATE(
    MAX('fVendas'[Data Pedido]),
    ALLSELECTED('dCalendario')
)
VAR vTabela = FILTER(
    VALUES('dCalendario'[Date]),
    'dCalendario'[Date] <= vUltimaDataComVenda
)
RETURN
CALCULATE(
    [Faturamento],
    DATESYTD(SAMEPERIODLASTYEAR(vTabela))
)

/*Resultado LY*/
/*-----------------------------------------------------*/
Resultado LY = 
VAR vUltimaDataComVenda = CALCULATE(
    MAX('fVendas'[Data Pedido]),
    ALLSELECTED('dCalendario')
)
VAR vTabela = FILTER(
    VALUES(dCalendario[Date]),
    'dCalendario'[Date] <= vUltimaDataComVenda
)
RETURN
CALCULATE(
    [Resultado],
    DATEADD(vTabela, -1, YEAR)
)

/*Resultado LM*/
/*-----------------------------------------------------*/
Resultado LM = 
VAR vUltimaDataComVenda = CALCULATE(
    MAX('fVendas'[Data Pedido]),
    ALLSELECTED('dCalendario'[Date])
)
VAR vTabela = FILTER(
    VALUES('dCalendario'[Date]),
    'dCalendario'[Date] <= vUltimaDataComVenda
)
RETURN
CALCULATE(
    [Resultado],
    DATEADD(vTabela, -1, MONTH)
)

/*Resultado % YoY*/
/*-----------------------------------------------------*/
Resultado % YoY = DIVIDE(
    [Resultado] - [Resultado LY],
    [Resultado LY]
)

/*Resultado % MoM*/
/*-----------------------------------------------------*/
Resultado % MoM = 
VAR vUltimaDataComVenda = CALCULATE(
    MAX('fVendas'[Data Pedido]),
    ALLSELECTED('dCalendario')
)
VAR vTabela = FILTER(
    VALUES(dCalendario[Date]),
    'dCalendario'[Date] <= vUltimaDataComVenda
)
VAR vResultadoMoM = CALCULATE(
    [Resultado],
    DATEADD(vTabela, -1, MONTH)
)
RETURN
DIVIDE(
    [Resultado] - vResultadoMoM,
    vResultadoMoM
)

/*Comissao LY*/
/*-----------------------------------------------------*/
Comissao LY = 
VAR vUltimaDataComVenda = CALCULATE(
    MAX('fVendas'[Data Pedido]),
    ALLSELECTED('dCalendario')
)
VAR vTabela = FILTER(
    VALUES('dCalendario'[Date]),
    'dCalendario'[Date] <= vUltimaDataComVenda
)
RETURN
CALCULATE(
    [Comissao],
    SAMEPERIODLASTYEAR(vTabela)
)

/*Comissao % YoY*/
/*-----------------------------------------------------*/
Comissao % YoY = DIVIDE(
    [Comissao] - [Comissao LY],
    [Comissao LY]
)

/*Margem % LY*/
/*-----------------------------------------------------*/
Margem % LY = 
VAR vUltimaDataComVenda = CALCULATE(
    MAX('fVendas'[Data Pedido]),
    ALLSELECTED('dCalendario'[Date])
)
VAR vTabela = FILTER(
    VALUES('dCalendario'[Date]),
    'dCalendario'[Date] <= vUltimaDataComVenda
)
RETURN
CALCULATE(
    [Margem %],
    SAMEPERIODLASTYEAR(vTabela)
) 

/*Margem % LM*/
/*-----------------------------------------------------*/
Margem % LM = 
VAR vUltimaDataComVenda = CALCULATE(
    MAX('fVendas'[Data Pedido]),
    ALLSELECTED('dCalendario'[Date])
)
VAR vTabela = FILTER(
    VALUES('dCalendario'[Date]),
    'dCalendario'[Date] <= vUltimaDataComVenda
)
RETURN
CALCULATE(
    [Margem %],
    DATEADD(vTabela, -1, MONTH))

/*Margem % YoY*/
/*-----------------------------------------------------*/
Margem % YoY = DIVIDE(
    [Margem %] - [Margem % LY],
    [Margem % LY]
)