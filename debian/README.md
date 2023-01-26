# Debian Dotfiles
Este é um repositório com todas as principais instalações que faço em distribuições debian. Para efeitos de registro, os comandos foram testados nas distros Ubuntu e PopOS. 

## O que é instalado no sistema?
**Estilizar o terminal**: Zsh, Oh My Zsh!, Zsh-autosuggestions, Powerlevel10k
	
**Desenvolvimento**: NodeJS, NPM, Yarn, VSCodium, Chrome e Docker (Engine/Compose)
	
**Comunicação**: Signal e Microsoft Teams

### Fontes MesloLGS NF
Embora não seja obrigatório, o uso da fonte é recomendado para caso vá utilizar o tema PowerLevel10k no seu terminal. Para instalar siga os seguintes passos:

Acesse a pasta 'fonts', dê um duplo-clique em cada fonte e a instale. 
Feito isso, acesse as configurações do terminal e altere a fonte para MesloLGS NF.

Para mais informações sobre o uso de fontes no tema Powerlevel10k, [clique aqui.](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)
	
## O que fazer caso não queira algum desses programas?
O primeiro passo é identificar qual arquivo .sh instala o programa indesejado (você pode encontrar essa informação na seção [Arquivos](https://github.com/thigcampos/desktop/edit/main/README.md#arquivos). Feito isso, edite o arquivo com o Editor de Texto, adicionando uma **hashtag (#)** no início da linha do comando de instalação o programa, lembrando cada arquivo possui comentários que identificam o programa que o código instala. 

## Arquivos
Nessa seção está descrito o que é instalado em cada arquivo .sh, assim como os comandos necessários para instalá-los.

### basic.sh
Aqui a pasta de fontes e o arquivo zshrc são renomeados e movidos para a Home, são passos importantes para a parte de estilização do terminal. Caso não vá mexer em seu terminal, ignore esse arquivo.

Para iniciar o básico, rode:
	
	chmod +x basic.sh && ./basic.sh

### zsh.sh
Instalação do zsh e do oh my zsh!
Acesse o terminal na pasta em que estão os arquivos zsh.sh e o powerlevel.sh.

Execute o seguinte comando:
	
	./zsh.sh

### plugins.sh
Instalação de zsh-autosuggestions e do tema powerlevel10k

Execute:
	
	./powerlevel.sh
	
Para que a instalação seja completa, reinicie o seu computador.

### development.sh
Instalação do NodeJS, NPM, Yarn, Chrome, VSCodium e Docker

Acesse o terminal na pasta em que está o arquivo development.sh .
Execute o seguinte comando:
	
	chmod +x development.sh && ./development.sh

### communication.sh
Signal e Microsoft Teams

No mesmo terminal que utilizou na etapa anterior, execute:
	
	chmod +x communication.sh && ./communication
	
## Referências
[ZSH e Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)

[ZSH Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

[PowerLevel10k](https://github.com/romkatv/powerlevel10k)

## Dúvidas e Sugestões
Entre em contato comigo via [Email](mailto:vd5fsfx7@anonaddy.me), [Twitter](https://twitter.com/thigcampos_) ou [Reddit](https://www.reddit.com/user/thigcampos_/)
	
