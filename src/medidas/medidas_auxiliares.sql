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

/*Velocimetro*/
/*-----------------------------------------------------*/
Velocimetro = 
VAR vMetaCor = SWITCH(
    TRUE(),
    [Meta %] >= 1, "#59b7c8",
    [Meta %] >= 0.81, "#897d2e",
    "#FE9292"
)
VAR vValor = [Meta %]
VAR vValorFormatado = FORMAT(vValor, "0%")
VAR vRotacao = ROUND(186 * vValor, 0)
VAR vRotacaoAjustada = IF(vRotacao <= 262, vRotacao, 262)
VAR vVibracaoVelocimetro = SWITCH(
    TRUE(),
    [Meta %] >= 1, "3",
    [Meta %] >= 0.81, "1.5",
    ".5"
)
/*formatacao------------------------------*/
VAR vFonte = "Segoe UI"
VAR vRotuloCategoria = "Meta %"
VAR vTamanhoRotuloCategoria = "13"
VAR vTamanhoRotuloDados = "30"
VAR vCorRotuloCategoria = "#FFFFFF"
VAR vCorMarcadores = "#FFFFFF"
VAR vCorNumeros = "#FFFFFF"
VAR vCorRotuloDados = vMetaCor
VAR vCorSeta = vMetaCor
VAR vCorMarcadorMaximo = vMetaCor
VAR vCorContornoInterno = vMetaCor
VAR vCorMax = vMetaCor
/*----------------------------------------*/
RETURN
"data:image/svg+xml,
<svg width='250' height='220' viewBox='0 0 250 220' fill='none' xmlns='http://www.w3.org/2000/svg'>
    <defs>
        <style>
            #ponteiro {
                transform: rotate("&vRotacaoAjustada&"deg);
                transform-origin: center;
                transform-box: fill-box
            }
            #marcadores, #numeros, #rot_dados, #rot_categoria {      
                animation: vibrate-1 0.1s linear infinite alternate both;
            }
            @keyframes vibrate-1 {
            0% {
                transform: translate(0);
            }
            20% {
                transform: translate(-"&vVibracaoVelocimetro&"px, "&vVibracaoVelocimetro&"px);
            }
            40% {
                transform: translate(-"&vVibracaoVelocimetro&"px, -"&vVibracaoVelocimetro&"px);
            }
            60% {
                transform: translate("&vVibracaoVelocimetro&"px, "&vVibracaoVelocimetro&"px);
            }
            80% {
                transform: translate("&vVibracaoVelocimetro&"px, -"&vVibracaoVelocimetro&"px);
            }
            100% {
                transform: translate(0);
            }
        </style>
    </defs>
	<g id='velocimetro'>
		<g id='marcadores'>
			<path id='marcador' d='M63.9824 166.968L50.1973 178.951L49.8379 178.537L63.623 166.555L63.9824 166.968ZM61.542 163.912L54.3457 169.535L54.0088 169.104L61.2051 163.48L61.542 163.912ZM58.9834 160.453L51.502 165.691L51.1875 165.242L58.6689 160.004L58.9834 160.453ZM56.6084 156.865L48.8633 161.704L48.5732 161.24L56.3174 156.4L56.6084 156.865ZM54.4238 153.157L46.4365 157.584L46.1709 157.105L54.1582 152.678L54.4238 153.157ZM52.4375 149.341L44.2295 153.345L43.9893 152.852L52.1973 148.849L52.4375 149.341ZM50.6523 145.426L42.2461 148.994L42.0322 148.489L50.4385 144.921L50.6523 145.426ZM49.0752 141.422L40.4941 144.546L40.3066 144.03L48.8877 140.907L49.0752 141.422ZM47.71 137.342L38.9766 140.012L38.8164 139.487L47.5498 136.817L47.71 137.342ZM46.5605 133.195L37.6992 135.404L37.5664 134.873L46.4277 132.663L46.5605 133.195ZM45.6289 128.994L36.6641 130.736L36.5596 130.198L45.5244 128.456L45.6289 128.994ZM44.9189 124.749L35.875 126.021L35.7988 125.478L44.8428 124.207L44.9189 124.749ZM44.4316 120.475L35.334 121.271L35.2861 120.725L44.3838 119.929L44.4316 120.475ZM44.1689 116.179L35.042 116.497L35.0225 115.949L44.1494 115.631L44.1689 116.179ZM44.1406 111.328L44.1309 111.876L35 111.717L35.0098 111.169L44.1406 111.328ZM44.3574 107.031L44.3193 107.577L35.209 106.94L35.2471 106.394L44.3574 107.031ZM44.7979 102.749L44.7314 103.293L35.667 102.18L35.7344 101.636L44.7979 102.749ZM45.4629 98.4971L45.3672 99.0371L36.374 97.4512L36.4688 96.9111L45.4629 98.4971ZM46.3486 94.2881L46.2256 94.8213L37.3271 92.7676L37.4502 92.2334L46.3486 94.2881ZM47.4541 90.1289L47.3027 90.6562L38.5244 88.1387L38.6748 87.6123L47.4541 90.1289ZM48.7744 86.0332L48.5967 86.5508L39.9619 83.5781L40.1396 83.0596L48.7744 86.0332ZM50.3086 82.0117L50.1035 82.5205L41.6357 79.0986L41.8418 78.5908L50.3086 82.0117ZM52.0508 78.0771L51.8193 78.5742L43.543 74.7148L43.7744 74.2178L52.0508 78.0771ZM53.9971 74.2393L53.7393 74.7227L45.6758 70.4355L45.9336 69.9521L53.9971 74.2393ZM56.1406 70.5078L55.8584 70.9775L48.0303 66.2744L48.3125 65.8047L56.1406 70.5078ZM58.4766 66.8955L58.1709 67.3496L50.5996 62.2432L50.9062 61.7891L58.4766 66.8955ZM60.999 63.4082L60.6689 63.8457L53.376 58.3496L53.7051 57.9121L60.999 63.4082ZM198.612 57.5166L191.416 63.1387L191.078 62.707L198.274 57.085L198.612 57.5166ZM63.7002 60.0576L63.3477 60.4775L56.3525 54.6074L56.7041 54.1875L63.7002 60.0576ZM195.593 53.8096L188.701 59.8008L188.342 59.3877L195.233 53.3965L195.593 53.8096ZM66.5732 56.8555L66.1992 57.2559L59.5205 51.0273L59.8936 50.627L66.5732 56.8555ZM192.385 50.2656L185.815 56.6094L185.435 56.2158L192.004 49.8721L192.385 50.2656ZM69.6094 53.8057L69.2148 54.1865L62.8711 47.6172L63.2656 47.2363L69.6094 53.8057ZM188.994 46.8936L182.766 53.5732L182.365 53.1992L188.594 46.5205L188.994 46.8936ZM72.8008 50.9199L72.3877 51.2793L66.3965 44.3867L66.8096 44.0273L72.8008 50.9199ZM185.433 43.7041L179.562 50.7002L179.143 50.3486L185.013 43.3525L185.433 43.7041ZM76.1396 48.2051L75.708 48.542L70.0859 41.3457L70.5176 41.0088L76.1396 48.2051ZM181.708 40.7051L176.213 47.999L175.774 47.6689L181.271 40.375L181.708 40.7051ZM79.6162 45.6689L79.167 45.9834L73.9297 38.5029L74.3779 38.1885L79.6162 45.6689ZM177.833 37.9043L172.726 45.4756L172.271 45.1689L177.379 37.5986L177.833 37.9043ZM83.2197 43.3174L82.7559 43.6074L77.916 35.8623L78.3809 35.5723L83.2197 43.3174ZM173.815 35.3115L169.112 43.1396L168.643 42.8574L173.346 35.0293L173.815 35.3115ZM86.9424 41.1582L86.4629 41.4238L82.0352 33.4365L82.5146 33.1709L86.9424 41.1582ZM169.668 32.9326L165.381 40.9961L164.897 40.7383L169.185 32.6748L169.668 32.9326ZM90.7725 39.1963L90.2803 39.4365L86.2764 31.2285L86.7695 30.9883L90.7725 39.1963ZM165.402 30.7734L161.543 39.0508L161.046 38.8184L164.906 30.542L165.402 30.7734ZM94.7002 37.4375L94.1953 37.6514L90.627 29.2451L91.1318 29.0312L94.7002 37.4375ZM161.029 28.8408L157.608 37.3076L157.1 37.1025L160.521 28.6348L161.029 28.8408ZM98.7139 35.8877L98.1992 36.0752L95.0762 27.4932L95.5908 27.3066L98.7139 35.8877ZM156.562 27.1406L153.588 35.7754L153.069 35.5967L156.043 26.9619L156.562 27.1406ZM102.804 34.5488L102.28 34.709L99.6104 25.9756L100.134 25.8154L102.804 34.5488ZM152.01 25.6758L149.492 34.4541L148.966 34.3027L151.482 25.5244L152.01 25.6758ZM106.958 33.4268L106.427 33.5596L104.217 24.6982L104.749 24.5664L106.958 33.4268ZM147.388 24.4492L145.333 33.3477L144.8 33.2246L146.854 24.3262L147.388 24.4492ZM111.165 32.5244L110.628 32.6289L108.885 23.6641L109.423 23.5596L111.165 32.5244ZM142.709 23.4688L141.123 32.4619L140.583 32.3672L142.169 23.373L142.709 23.4688ZM115.414 31.8408L114.872 31.917L113.601 22.874L114.144 22.7979L115.414 31.8408ZM137.984 22.7334L136.871 31.7979L136.327 31.7314L137.44 22.667L137.984 22.7334ZM119.692 31.3838L119.146 31.4307L118.351 22.333L118.896 22.2861L119.692 31.3838ZM133.228 22.2471L132.591 31.3574L132.044 31.3184L132.681 22.209L133.228 22.2471ZM123.989 31.1484L123.442 31.168L123.123 22.041L123.671 22.0215L123.989 31.1484ZM128.452 22.0098L128.293 31.1406L127.745 31.1309L127.904 22L128.452 22.0098Z' fill='"&vCorMarcadores&"'/>
            <path id='marcador_maximo' d='M202.696 178.38L201.788 179.407L188.109 167.304L189.017 166.278L202.696 178.38ZM199.245 168.271L198.421 169.365L191.127 163.869L191.951 162.775L199.245 168.271ZM202.022 164.378L201.256 165.514L193.685 160.408L194.45 159.272L202.022 164.378ZM204.591 160.346L203.885 161.52L196.057 156.817L196.763 155.642L204.591 160.346ZM206.946 156.184L206.302 157.394L198.239 153.107L198.882 151.897L206.946 156.184ZM209.078 151.906L208.499 153.147L200.223 149.287L200.802 148.046L209.078 151.906ZM210.985 147.521L210.472 148.791L202.004 145.37L202.518 144.1L210.985 147.521ZM212.659 143.042L212.213 144.337L203.578 141.365L204.025 140.069L212.659 143.042ZM214.097 138.483L213.719 139.8L204.941 137.283L205.319 135.966L214.097 138.483ZM215.294 133.855L214.986 135.19L206.087 133.135L206.396 131.8L215.294 133.855ZM216.247 129.169L216.009 130.518L207.016 128.932L207.253 127.583L216.247 129.169ZM216.954 124.441L216.787 125.8L207.723 124.687L207.89 123.328L216.954 124.441ZM217.412 119.681L217.317 121.048L208.206 120.411L208.302 119.044L217.412 119.681ZM217.62 114.905L217.597 116.275L208.466 116.115L208.49 114.745L217.62 114.905ZM217.627 111.492L208.5 111.811L208.452 110.442L217.579 110.122L217.627 111.492ZM217.406 106.716L208.309 107.512L208.19 106.148L217.287 105.352L217.406 106.716ZM216.937 101.956L207.893 103.227L207.702 101.87L216.746 100.6L216.937 101.956ZM216.218 97.2299L207.253 98.973L206.992 97.6283L215.957 95.8851L216.218 97.2299ZM215.253 92.5472L206.392 94.7562L206.061 93.4271L214.922 91.2172L215.253 92.5472ZM214.045 87.9203L205.312 90.5902L204.911 89.2806L213.645 86.6107L214.045 87.9203ZM212.596 83.3636L204.014 86.4867L203.546 85.1996L212.127 82.0765L212.596 83.3636ZM210.91 78.889L202.504 82.4574L201.969 81.1957L210.375 77.6273L210.91 78.889ZM208.992 74.5072L200.784 78.5101L200.184 77.2787L208.392 73.2758L208.992 74.5072ZM206.849 70.2338L198.861 74.6615L198.197 73.4633L206.185 69.0355L206.849 70.2338ZM204.484 66.0775L196.74 70.9164L196.013 69.7552L203.758 64.9154L204.484 66.0775ZM209.638 56.8978L194.676 67.3744L193.891 66.2523L208.852 55.7758L209.638 56.8978Z' fill='"&vCorMarcadorMaximo&"'/>
		</g>
		<g id='ponteiro'>
			<circle id='circulo_giro' cx='126.507' cy='113.504' r='91.5' fill='#0000' fill-opacity='0.1'/>
            <path id='seta' d='M66.4907 166.897C65.8357 166.988 65.3045 166.374 65.4884 165.739L71.9101 143.559C72.3576 142.013 74.4489 141.752 75.2733 143.133C77.2674 146.476 80.102 151.102 81.3931 152.619C82.7189 154.176 86.8698 158.01 89.7532 160.628C90.9069 161.676 90.316 163.604 88.7724 163.817L66.4907 166.897Z' fill='"&vCorSeta&"'/>
		</g>
		<g id='numeros'>
			<text id='0' fill='"&vCorNumeros&"' font-family='"&vFonte&"' font-size='15'>
				<tspan x='34' y='190.211'>0</tspan>
			</text>
			<text id='20' fill='"&vCorNumeros&"' font-family='"&vFonte&"' font-size='15'>
				<tspan x='12' y='128.211'>20</tspan>
			</text>
			<text id='40' fill='"&vCorNumeros&"' font-family='"&vFonte&"' font-size='15'>
				<tspan x='26' y='64.2109'>40</tspan>
			</text>
			<text id='60' fill='"&vCorNumeros&"' font-family='"&vFonte&"' font-size='15'>
				<tspan x='81' y='23.2109'>60</tspan>
			</text>
			<text id='80' fill='"&vCorNumeros&"' font-family='"&vFonte&"' font-size='15'>
				<tspan x='150' y='21.2109'>80</tspan>
			</text>
			<text id='100' fill='"&vCorNumeros&"' font-family='"&vFonte&"' font-size='15'>
				<tspan x='211' y='59.2109'>100</tspan>
			</text>
			<text id='max' fill='"&vCorMax&"' font-family='"&vFonte&"' font-size='15'>
				<tspan x='205' y='190.211'>MAX</tspan>
			</text>
		</g>
		<text text-anchor='middle' id='rot_dados' fill='"&vCorRotuloDados&"' font-family='Montserrat' font-size='"&vTamanhoRotuloDados&"' font-weight='600'>
			<tspan x='125' y='126.255'>"&vValorFormatado&"</tspan>
		</text>
		<text text-anchor='middle' id='rot_categoria' fill='"&vCorRotuloCategoria&"' fill-opacity='0.6' font-family='"&vFonte&"' font-size='"&vTamanhoRotuloCategoria&"'>
			<tspan x='125' y='93.8828'>"&vRotuloCategoria&"</tspan>
		</text>
	</g>
</svg>
"

/*Foto Vendedor*/
/*-----------------------------------------------------*/
Foto Vendedor = 
VAR vFoto = SELECTEDVALUE('dVendedores'[URL Foto])
RETURN
 "
    <style>
        div {
            display: flex;
            justify-content: center;
            align-items: center
        }
        img {
            width: 90vw;
            height: 90vw;
            object-fit: cover;
            border-radius: 50%;
            animation: rotate-scale-down 0.65s linear both
        }
        @keyframes rotate-scale-down {
            0% {
                transform: scale(1) rotateZ(0);
            }
            50% {
                transform: scale(0.5) rotateZ(180deg);
            }
            100% {
                transform: scale(1) rotateZ(360deg);
            }
        }
    </style>
    <img src='"&vFoto&"'>
 "