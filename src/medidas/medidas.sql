/*Faturamento*/
/*-----------------------------------------------------*/
Faturamento = CALCULATE( 
    SUMX('fVendas', 'fVendas'[Qtde] * 'fVendas'[Valor Unit]), 'dStatus'[Id Status] = 1 
)

/*Custo*/
/*-----------------------------------------------------*/
Custo = CALCULATE(
    SUMX('fVendas', 'fVendas'[Qtde] * 'fVendas'[Custo Unit]), 'dStatus'[Id Status] = 1
)

/*Despesa*/
/*-----------------------------------------------------*/
Despesa = CALCULATE(
    SUMX('fVendas', 'fVendas'[Qtde] * 'fVendas'[Despesa Unit]), 'dStatus'[Id Status] = 1
)

/*Imposto*/
/*-----------------------------------------------------*/
Imposto = CALCULATE(
    SUMX('fVendas', 'fVendas'[Qtde] * 'fVendas'[Impostos Unit]), 'dStatus'[Id Status] = 1
)

/*Comissao*/
/*-----------------------------------------------------*/
Comissao = CALCULATE(
    SUMX('fVendas', 'fVendas'[Qtde] * 'fVendas'[Comissão Unit]), 'dStatus'[Id Status] = 1
)

/*Abatimento*/
/*-----------------------------------------------------*/
Abatimento = [Custo] + [Despesa] + [Imposto] + [Comissao]

/*Resultado*/
/*-----------------------------------------------------*/
Resultado = [Faturamento] - [Abatimento]

/*Margem %*/
/*-----------------------------------------------------*/
Margem % = DIVIDE([Resultado], [Faturamento])

/*Meta*/
/*-----------------------------------------------------*/
Meta = SUM('fMetas'[Valor])

/*Diferenca da Meta*/
/*-----------------------------------------------------*/
Diferenca da Meta = [Faturamento] - [Meta] 

/*Meta %*/
/*-----------------------------------------------------*/
Meta % = DIVIDE([Faturamento], [Meta])

/*Positivacao Clientes*/
/*-----------------------------------------------------*/
Positivacao Clientes = DISTINCTCOUNT('fVendas'[Id Cliente])

/*Positivacao Produtos*/
/*-----------------------------------------------------*/
Positivacao Produtos = DISTINCTCOUNT('fVendas'[Id Produto])

/*Qtde Vendas*/
/*-----------------------------------------------------*/
Qtde Vendas = DISTINCTCOUNT('fVendas'[Num Venda])

/*Rank Cidade Faturamento*/
/*-----------------------------------------------------*/
Rank Cidade Faturamento = RANKX(
    ALL('dClientes'[Cidade]),
    [Faturamento]
)