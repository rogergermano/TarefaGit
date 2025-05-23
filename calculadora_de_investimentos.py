#Calculadora de investimentos.

-Versão 0.1
"""

print("--- Calculadora de Investimentos com Juros Compostos ---")

nome = input("Digite seu nome: ")

while True:
    try:
        idade_str = input("Digite sua idade: ")
        idade = int(idade_str)
        if idade <= 0:
            print("Por favor, digite uma idade válida.")
        else:
            break
    except ValueError:
        print("Por favor, digite um número inteiro para a idade.")

print("\nEscolha o tipo de investimento:")
print("1 - CDI (13% a.a.)")
print("2 - Tesouro Direto (12,5% a.a.)")
print("3 - Poupança (0,8% a.m.)")

while True:
    opcao_investimento_str = input("Digite o número da sua escolha: ")
    try:
        opcao_investimento = int(opcao_investimento_str)
        if opcao_investimento in [1, 2, 3]:
            break
        else:
            print("Opção inválida. Escolha entre 1, 2 ou 3.")
    except ValueError:
        print("Por favor, digite um número.")

taxa_mensal = 0
tipo_investimento = ""
if opcao_investimento == 1:
    taxa_mensal = 0.13 / 12
    tipo_investimento = "CDI"
elif opcao_investimento == 2:
    taxa_mensal = 0.125 / 12
    tipo_investimento = "Tesouro Direto"
elif opcao_investimento == 3:
    taxa_mensal = 0.008
    tipo_investimento = "Poupança"

while True:
    periodo_meses_str = input("Digite o período de investimento em meses (máximo 60): ")
    try:
        periodo_meses = int(periodo_meses_str)
        if 1 <= periodo_meses <= 60:
            break
        else:
            print("O período de investimento deve ser entre 1 e 60 meses.")
    except ValueError:
        print("Por favor, digite um número inteiro para o período.")

while True:
    valor_inicial_str = input("Digite o valor inicial do investimento: ")
    try:
        valor_inicial = float(valor_inicial_str)
        if valor_inicial >= 0:
            break
        else:
            print("O valor inicial deve ser um número não negativo.")
    except ValueError:
        print("Por favor, digite um número válido para o valor inicial.")

fazer_aporte = input("Você fará aportes mensais? (sim/não): ")

aporte_mensal = 0
if fazer_aporte.lower() == "sim":
    while True:
        aporte_mensal_str = input("Digite o valor do aporte mensal: ")
        try:
            aporte_mensal = float(aporte_mensal_str)
            if aporte_mensal >= 0:
                break
            else:
                print("O valor do aporte mensal deve ser um número não negativo.")
        except ValueError:
            print("Por favor, digite um número válido para o aporte mensal.")

valor_final = valor_inicial
for _ in range(periodo_meses):
    valor_final = (valor_final + aporte_mensal) * (1 + taxa_mensal)

print("\n--- Resultados do Investimento ---")
print("Nome do Investidor:", nome)
print("Idade do Investidor:", idade, "anos")
print("Tipo de Investimento Escolhido:", tipo_investimento)
print("Período de Investimento:", periodo_meses, "meses")
print("Valor Inicial Investido: R$", "{:.2f}".format(valor_inicial))
if aporte_mensal > 0:
    print("Aporte Mensal: R$", "{:.2f}".format(aporte_mensal))
else:
    print("Sem aportes mensais.")
print("Valor Final Projetado: R$", "{:.2f}".format(valor_final))
