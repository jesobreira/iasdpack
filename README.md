# IASD Apps

Pacote de ferramentas auxiliares para sonoplastas de igrejas

Os aplicativos foram desenvolvidos usando a linguagem AutoIt.
Baixe a IDE com compilador pelo site: http://www.autoitscript.com/

As interfaces gráficas foram criadas usando o programa Koda.
Baixe-o pelo site: http://koda.darkhost.ru/

O arquivo principal (o único compilado) de cada projeto é sempre "main.au3" ou "main.bat" (verifique os sufixos).

O aplicativo "Matar Photodex" foi desenvolvido usando Batch (arquivo em lotes).
Foi utilizado o Bat to Exe Converter para compilar.

Quanto à tela em que será exibida, arquivo com sufixo "-mono" rodam na tela principal, enquanto que arquivos com sufixo "-double" rodam na segunda tela. Arquivos sem sufixo rodam na tela principal.

Arquivos compilados devem ser colocados de forma organizada na pasta "build". Após a edição, execute:

**No Windows**
```
del IASDApps.zip
build.bat
```

**No Linux**

```sh
$ rm IASDApps.zip
$ chmod +x build.sh
$ ./build.sh
```