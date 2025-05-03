function Nova-ContaBancaria {
    param (
        [string]$Nome,
        [double]$SaldoInicial
    )

    $conta = [PSCustomObject]@{
        Nome  = $Nome
        Saldo = $SaldoInicial

        Depositar = {
            param ($valor)
            $this.Saldo += $valor
            Write-Host "Depósito de R$$valor realizado."
            Write-Host "Novo saldo: R$$($this.Saldo)"
        }

        Sacar = {
            param ($valor)
            if ($valor -le $this.Saldo) {
                $this.Saldo -= $valor
                Write-Host "Saque de R$$valor realizado."
                Write-Host "Saldo atual: R$$($this.Saldo)"
            } else {
                Write-Host "Saldo insuficiente."
                Write-Host "Operação não realizada."
            }
        }

        MostrarSaldo = {
            Write-Host "Nome da conta: $($this.Nome)"
            Write-Host "Saldo: R$$($this.Saldo)"
        }
    }

    return $conta
}

# Execução
$conta = Nova-ContaBancaria -Nome "Joao" -SaldoInicial 500.00
$conta.MostrarSaldo.Invoke()
$conta.Depositar.Invoke(200.0)
$conta.Sacar.Invoke(1000.0)
$conta.Sacar.Invoke(300.0)
$conta.MostrarSaldo.Invoke()
