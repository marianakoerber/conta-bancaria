<#
.SYNOPSIS
    Simulação de uma conta bancária usando PowerShell com operações básicas.

.DESCRIPTION
    O script cria um objeto de conta bancária que permite depositar, sacar
    e visualizar o saldo, utilizando um objeto com métodos encapsulados.
#>

function Nova-ContaBancaria {
    param (
        [string]$NomeTitular,
        [double]$SaldoInicial
    )

    if ($SaldoInicial -lt 0) {
        throw "Saldo inicial não pode ser negativo."
    }

    $conta = [PSCustomObject]@{
        NomeTitular = $NomeTitular
        Saldo       = $SaldoInicial

        Depositar = {
            param ($valor)
            if ($valor -le 0) {
                Write-Output "Valor inválido para depósito."
                return
            }
            $this.Saldo += $valor
            Write-Output ("Depósito de R${0:N2} realizado." -f $valor)
            $this.MostrarSaldo.Invoke()
        }

        Sacar = {
            param ($valor)
            if ($valor -le 0) {
                Write-Output "Valor inválido para saque."
                return
            }

            if ($valor -le $this.Saldo) {
                $this.Saldo -= $valor
                Write-Output ("Saque de R${0:N2} realizado." -f $valor)
            } else {
                Write-Output "Saldo insuficiente. Operação não realizada."
            }

            $this.MostrarSaldo.Invoke()
        }

        MostrarSaldo = {
            Write-Output ("Titular: {0} | Saldo atual: R${1:N2}" -f $this.NomeTitular, $this.Saldo)
        }
    }

    return $conta
}

# --- Execução de exemplo ---
$conta = Nova-ContaBancaria -NomeTitular "João" -SaldoInicial 500.00
$conta.MostrarSaldo.Invoke()
$conta.Depositar.Invoke(200.0)
$conta.Sacar.Invoke(1000.0)
$conta.Sacar.Invoke(300.0)
$conta.MostrarSaldo.Invoke()
