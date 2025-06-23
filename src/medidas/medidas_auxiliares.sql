/*Eixo Y Max*/
/*-----------------------------------------------------*/
Eixo Y Max = 
VAR vTabela = ALLSELECTED(
    'dCalendario'[Mes Nome Abreviado], 'dCalendario'[Mes]
)
VAR vMaiorValor = MAXX(
    vTabela, [Faturamento]
)
RETURN
vMaiorValor * 1.5

/*Faturamento Formatado*/
/*-----------------------------------------------------*/
Faturamento Formatado = 
VAR vValor = [Faturamento]
RETURN 
SWITCH(
    TRUE(),
    vValor >= 1000000000, FORMAT(vValor, "0,0,,,.0 Bi"),
    vValor >= 1000000, FORMAT(vValor, "0,0,,.0 Mi"),
    vValor >= 1000000000, FORMAT(vValor, "0,0,.0 K"),
    FORMAT(vValor, "0")
)

/*Imagem Cartao Faturamento*/
/*-----------------------------------------------------*/
Imagem Cartao Faturamento = 
/*formatacao------------------------------*/
VAR vFonte = "Segoe UI"
VAR vRotuloCategoria = "Vs. Ano Anterior"
VAR vCorCategoria = "94FE92"
/*----------------------------------------*/
VAR vValor = [Faturamento % YoY]
VAR vValorFormatado = FORMAT(vValor + 0, "+0.0%;-0.0%;-")
VAR vSeta = SWITCH(
    TRUE(),
    vValor > 0, "⮝",
    vValor < 0, "⮟"
)
VAR vCor = SWITCH(
    TRUE(),
    vValor > 0, "#94FE92",
    vValor < 0, "#FE9292",
    "#F1F1F1"
)
VAR vAnimacao = IF(
    vValor < 0, "animation"
)
RETURN
"data:image/svg+xml,
<svg viewBox='0 0 190 50' fill='none' xmlns='http://www.w3.org/2000/svg'>
	<g id='cartao_variacao'>
        <defs>
            <style>
                #rotulo_dados, #seta {
                    "&vAnimacao&": blink-1 1.2s infinite both;
                }
                @keyframes blink-1 {
                    0%,
                    50%,
                    100% {
                        opacity: 1;
                    }
                    25%,
                    75% {
                        opacity: 0;
                    }
                }
            </style>
        </defs>
		<text id='rotulo_categoria' fill='white' xml:space='preserve' style='white-space: pre' font-family='"&vFonte&"' font-size='12' font-weight='600' letter-spacing='0em'>
			<tspan x='85' y='38.9688'>"&vRotuloCategoria&"</tspan>
		</text>
		<text id='seta' fill='"&vCor&"' xml:space='preserve' style='white-space: pre' font-family='Segoe UI' font-size='12' font-weight='600' letter-spacing='0em'>
			<tspan x='69' y='28.9688'>"&vSeta&"</tspan>
		</text>
		<text id='rotulo_dados' fill='"&vCor&"' xml:space='preserve' style='white-space: pre' font-family='Segoe UI' font-size='12' font-weight='600' letter-spacing='0em'>
			<tspan x='85' y='18.9688'>"&vValorFormatado&"</tspan>
		</text>
	</g>
</svg>
"

/*Imagem Tabela Cidade*/
/*-----------------------------------------------------*/
Imagem Tabela Cidade = 
/*formatacao------------------------------*/
VAR vFonte = "Segoe UI"
VAR vFonteCidadeTamanho = 12
VAR vRotuloCategoria = "Vs. Ano Anterior"
VAR vCorCidade = "#EAEAEA"
VAR vCorFaturamento = "#59B7C8"
VAR vCorMargem = "#D1783C"
VAR vCorLinha = "#B7A2C3"
/*----------------------------------------*/
VAR vCidade = SELECTEDVALUE(
    'dClientes'[Cidade]
)
VAR vValor = [Faturamento]
VAR vValorFormatado = SWITCH(
    TRUE(),
    ABS(vValor) >= 1e9, FORMAT(vValor, "#,0,,,.0 Bi"),
    ABS(vValor) >= 1e6, FORMAT(vValor, "#,0,,.0 Mi"),
    ABS(vValor) >= 1e3, FORMAT(vValor, "#,0,.0 Mil"),
    FORMAT(vValor, "0")
)
VAR vMargem = FORMAT([Margem %], "0.00%")
RETURN
"
<svg width='260' height='80' viewBox='0 0 260 65' fill='none' xmlns='http://www.w3.org/2000/svg'>
	<g id='tabela_cidades'>
        <defs>
            <style>
                #texto_cidade {
                    transition: .5s
                }
                svg:hover #texto_cidade {
                    transform: translateX(115px)
                }
                #texto_faturamento {
                    transition: .5s
                }
                svg:hover #texto_faturamento {
                    transform: translateX(-115px)
                }
                #texto_margem {
                    transition: .5s
                }
                svg:hover #texto_margem {
                    transform: translateX(-115px)
                }
            </style>
        </defs>
		<text id='texto_cidade' fill='"&vCorCidade&"' font-family='"&vFonte&"' font-size='"&vFonteCidadeTamanho&"'>
			<tspan x='30' y='35.9688'>"&vCidade&"</tspan>
		</text>

		<text id='texto_faturamento' fill='"&vCorFaturamento&"' font-family='"&vFonte&"' font-size='12'>
			<tspan x='160' y='26.9688'>R$ "&vValorFormatado&"</tspan>
		</text>

		<text id='texto_margem' fill='"&vCorMargem&"' font-family='"&vFonte&"' font-size='12'>
			<tspan x='160' y='49.9688'>"&vMargem&"</tspan>
		</text>

		<line id='linha' x1='129.5' y1='56' x2='129.5' y2='7.98959' stroke='"&vCorLinha&"' stroke-opacity='0.1'/>
	</g>

</svg>
"

/*Cor Transparente*/
/*-----------------------------------------------------*/
Cor Transparente = "#0000"