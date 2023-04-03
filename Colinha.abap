REPORT ZLAT_EX001 NO STANDARD PAGE HEADING.

PARAMETERS: pNome(40) TYPE c, "C para poder definir tamanho da cadeia de caracteres
            pAno(4)   TYPE n. "N para definir a quantidade de dígitos numéricos

DATA vIdade(3) TYPE c. "Definir tamanho do resultado para não dar erro

vIdade = sy-datum(4) - pAno.

WRITE:/ 'Sr(a). ', pNome,
      / 'Tem ', vIdade, ' anos.'.

uline. " Para imprimir uma linha

*--------------------------------------------------------------------------
*CÁLCULO IMC

data: v_imc type p decimals 2.

parameters: p_peso type p decimals 2, " Decimals 2 = 2 casas decimais após a vírgula
            p_altu type p decimals 2.

v_imc = p_peso / ( p_altu * p_altu ).

if v_imc < '17'. 
  write:/ 'O IMC é', v_imc, 'e a situação é "Muito abaixo do peso"'.

elseif v_imc >= '17' and v_imc < '18.5'. "Para utilizar decimais, deve-se utilizar o PONTO e colocá-lo entre aspas simples
  write:/ 'O IMC é', v_imc, 'e a situação é "Abaixo peso"'.

elseif v_imc >= '18.5' and v_imc < '25.0'.
  write:/ 'O IMC é', v_imc, 'e a situação é "Peso normal"'.

elseif v_imc >= '25.0' and v_imc < '30.0'.
  write:/ 'O IMC é', v_imc, 'e a situação é "Acima do peso"'.

elseif v_imc >= '30.0' and v_imc < '35.0'.
  write:/ 'O IMC é', v_imc, 'e a situação é "Obesidade I"'.

elseif v_imc >= '35.0' and v_imc < '40.0'.
  write:/ 'O IMC é', v_imc, 'e a situação é "Obesidade II (severa)"'.

elseif v_imc >= '40.0'.
  write:/ 'O IMC é', v_imc, 'e a situação é "Obesidade III (mórbida)"'.

endif.

uline.

*--------------------------------------------------------------------------





