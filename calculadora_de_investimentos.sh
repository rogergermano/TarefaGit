#!/bin/bash

echo "--- Calculadora de Investimentos com Juros Compostos ---"

read -p "Digite seu nome: " nome

while true; do
    read -p "Digite sua idade: " idade_str
    if [[ $idade_str =~ ^[0-9]+$ ]] && [ "$idade_str" -gt 0 ]; then
        idade=$idade_str
        break
    else
        echo "Por favor, digite uma idade válida."
    fi
done

echo -e "\nEscolha o tipo de investimento:"
echo "1 - CDI (13% a.a.)"
echo "2 - Tesouro Direto (12,5% a.a.)"
echo "3 - Poupança (0,8% a.m.)"

while true; do
    read -p "Digite o número da sua escolha: " opcao_investimento_str
    if [[ $opcao_investimento_str =~ ^[1-3]$ ]]; then
        opcao_investimento=$opcao_investimento_str
        break
    else
        echo "Opção inválida. Escolha entre 1, 2 ou 3."
    fi
done

case $opcao_investimento in
    1)
        taxa_mensal=$(echo "scale=10; 0.13 / 12" | bc)
        tipo_investimento="CDI"
        ;;
    2)
        taxa_mensal=$(echo "scale=10; 0.125 / 12" | bc)
        tipo_investimento="Tesouro Direto"
        ;;
    3)
        taxa_mensal=0.008
        tipo_investimento="Poupança"
        ;;
esac

while true; do
    read -p "Digite o período de investimento em meses (máximo 60): " periodo_meses_str
    if [[ $periodo_meses_str =~ ^[0-9]+$ ]] && [ "$periodo_meses_str" -ge 1 ] && [ "$periodo_meses_str" -le 60 ]; then
        periodo_meses=$periodo_meses_str
        break
    else
        echo "O período de investimento deve ser entre 1 e 60 meses."
    fi
done

while true; do
    read -p "Digite o valor inicial do investimento: " valor_inicial_str
    if [[ $valor_inicial_str =~ ^[0-9]+(\.[0-9]+)?$ ]] && [ $(echo "$valor_inicial_str >= 0" | bc) -eq 1 ]; then
        valor_inicial=$valor_inicial_str
        break
    else
        echo "O valor inicial deve ser um número não negativo."
    fi
done

read -p "Você fará aportes mensais? (sim/não): " fazer_aporte

aporte_mensal=0
if [[ "${fazer_aporte,,}" == "sim" ]]; then
    while true; do
        read -p "Digite o valor do aporte mensal: " aporte_mensal_str
        if [[ $aporte_mensal_str =~ ^[0-9]+(\.[0-9]+)?$ ]] && [ $(echo "$aporte_mensal_str >= 0" | bc) -eq 1 ]; then
            aporte_mensal=$aporte_mensal_str
            break
        else
            echo "O valor do aporte mensal deve ser um número não negativo."
        fi
    done
fi

valor_final=$valor_inicial
for ((i=0; i<periodo_meses; i++)); do
    valor_final=$(echo "scale=2; ($valor_final + $aporte_mensal) * (1 + $taxa_mensal)" | bc)
done

echo -e "\n--- Resultados do Investimento ---"
echo "Nome do Investidor: $nome"
echo "Idade do Investidor: $idade anos"
echo "Tipo de Investimento Escolhido: $tipo_investimento"
echo "Período de Investimento: $periodo_meses meses"
printf "Valor Inicial Investido: R$ %.2f\n" $valor_inicial
if [ $(echo "$aporte_mensal > 0" | bc) -eq 1 ]; then
    printf "Aporte Mensal: R$ %.2f\n" $aporte_mensal
else
    echo "Sem aportes mensais."
fi
printf "Valor Final Projetado: R$ %.2f\n" $valor_final
