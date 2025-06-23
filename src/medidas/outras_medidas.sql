/*Rank Cidade Top 5*/
/*-----------------------------------------------------*/
Rank Cidade Faturamento = CALCULATE(
    [Faturamento],
    FILTER(
        dCidades,
        [Rank Cidade Faturamento] <= 5
    )
)

/*Rank Cidade Top 5*/
/*-----------------------------------------------------*/
Rank Cidade Faturamento = CALCULATE(
    [Faturamento],
    KEEPFILTERS(
        TOPN(5, ALL(dCidades), [Faturamento])
    )
)

/*Rank % Cidade Top N*/
/*-----------------------------------------------------*/
VAR vRank = CALCULATE(
    [Faturamento],
    KEEPFILTERS(
        TOPN(
            [Segmentador Rank Cidade], 
            ALL(dCidades), 
            [Faturamento]
        )
    )
)
VAR vRankFixo = CALCULATE(
    [Faturamento],
    TOPN(
        [Segmentador Rank Cidade], 
        ALL(dCidades), 
        [Faturamento]
    )
)
RETURN
DIVIDE(
    vRank,
    vRankFixo
)

/*Produtos Sem Venda*/
/*-----------------------------------------------------*/
Produtos Sem Venda = 
VAR vProdutosComVenda = VALUES(
    'fVendas'[Id Produto]
)
VAR vProdutosCadastrados = VALUES(
    'dProdutos'[Id Produto]
)
VAR vResultado = EXCEPT(
    vProdutosCadastrados, vProdutosComVenda
)
RETURN
COUNTROWS(
    vResultado
)

/*Produtos Recorrentes Mes Anterior*/
/*-----------------------------------------------------*/
Produtos Recorrentes Mes Anterior = 
VAR vProdutosComVendaMesAtual = VALUES(
    'fVendas'[Id Produto]
)
VAR vProdutosComVendaMesAnterior = CALCULATETABLE(
    VALUES('fVendas'[Id Produto]),
    PREVIOUSMONTH('dCalendario'[Date])
)
VAR vResultado = INTERSECT(
    vProdutosComVendaMesAtual, vProdutosComVendaMesAnterior
)
RETURN
COUNTROWS(
    vResultado
)

/*Faturamento Data Envio*/
/*-----------------------------------------------------*/
Faturamento Data Envio = CALCULATE(
    [Faturamento],
    USERELATIONSHIP('dCalenario'[Date], 'fVendas'[Data Envio])
)