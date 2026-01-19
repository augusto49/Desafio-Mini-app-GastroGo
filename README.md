<p align="center">
  <img src="https://github.com/user-attachments/assets/05d994a8-1d41-4612-a9ad-8dba98004040" width="180" alt="Home Screen"/>
  <img src="https://github.com/user-attachments/assets/ba7e92ef-f46a-419e-88f3-52c73cb500b0" width="180" alt="Restaurant Details"/>
  <img src="https://github.com/user-attachments/assets/342d95df-4fe2-4ef0-9c84-5c1d74e40694" width="180" alt="Favorites"/>
</p>

<h1 align="center">🍽️ GastroGo</h1>

<p align="center">
  <strong>Mini aplicativo Flutter para descobrir restaurantes e pratos deliciosos</strong>
</p>

<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-3.29.3-02569B?logo=flutter&logoColor=white" alt="Flutter Version"/></a>
  <a href="https://dart.dev"><img src="https://img.shields.io/badge/Dart-3.7-0175C2?logo=dart&logoColor=white" alt="Dart Version"/></a>
  <a href="https://riverpod.dev"><img src="https://img.shields.io/badge/Riverpod-State%20Management-blue" alt="Riverpod"/></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green" alt="License"/></a>
</p>

<p align="center">
  <a href="#-funcionalidades">Funcionalidades</a> •
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-arquitetura">Arquitetura</a> •
  <a href="#-testes">Testes</a> •
  <a href="#-ci">CI</a>
</p>

---

## ✨ Funcionalidades

| Feature                         | Descrição                                       |
| ------------------------------- | ----------------------------------------------- |
| 🏠 **Listagem de Restaurantes** | Navegue por restaurantes com paginação infinita |
| 🔍 **Busca & Filtros**          | Pesquise e ordene por avaliação ou distância    |
| 📖 **Detalhes do Restaurante**  | Veja cardápio completo com pratos e preços      |
| ❤️ **Favoritos**                | Salve seus restaurantes e pratos preferidos     |
| 🔄 **Pull-to-Refresh**          | Atualize os dados com gesto de arrastar         |
| ⚡ **Simulação de API**         | Erros simulados para testar resiliência         |

---

## 🚀 Quick Start

### Pré-requisitos

- **Flutter** 3.29.3+
- **Dart** SDK compatível
- Android Studio / VS Code com extensões Flutter

### Instalação

```bash
# Clone o repositório
git clone https://github.com/augusto49/Desafio-Mini-app-GastroGo-.git

# Entre na pasta do projeto
cd gastrogo

# Instale as dependências
flutter pub get

# Execute o app
flutter run
```

> [!TIP]
> **Simulação de Erros:** O app simula falhas de API. Se uma tela mostrar erro, recarregue ou tente novamente — isso é intencional para demonstrar tratamento de erros.

---

## 🏗️ Arquitetura

O projeto segue **Clean Architecture** com separação clara de responsabilidades:

```
📁 lib/
 ┣ 📂 core/           # Utilidades e constantes globais
 ┣ 📂 data/           # Camada de dados
 ┃ ┣ 📂 models/       # Modelos de dados (JSON ↔ Entity)
 ┃ ┣ 📂 repositories/ # Implementação dos repositórios
 ┃ ┗ 📂 sources/      # Fontes de dados (local/remota)
 ┣ 📂 domain/         # Regras de negócio
 ┃ ┣ 📂 entities/     # Entidades de domínio
 ┃ ┗ 📂 usecases/     # Casos de uso
 ┣ 📂 presentation/   # UI e estado
 ┃ ┣ 📂 pages/        # Telas do app
 ┃ ┣ 📂 providers/    # Gerenciamento de estado (Riverpod)
 ┃ ┗ 📂 widgets/      # Componentes reutilizáveis
 ┗ 📄 main.dart       # Entry point
```

### Decisões Técnicas

| Tecnologia               | Justificativa                                                |
| ------------------------ | ------------------------------------------------------------ |
| **Riverpod**             | Gerenciamento de estado seguro, tipado e com suporte a async |
| **Repository Pattern**   | Desacopla fonte de dados, facilitando troca por API real     |
| **SharedPreferences**    | Persistência leve para favoritos                             |
| **cached_network_image** | Cache de imagens com placeholders                            |

---

## 🧪 Testes

### Executar Testes

```bash
# Testes unitários e de widget
flutter test

# Com cobertura
flutter test --coverage
```

### Tipos de Testes Incluídos

- ✅ **Unitários** — Repositórios e fontes de dados
- ✅ **Widget** — Lista e detalhes de restaurante

---

## 🔍 Lint & Análise

O projeto utiliza **Very Good Analysis** para garantir qualidade de código:

```bash
# Análise estática
flutter analyze

# Very Good Analysis
dart run very_good_analysis:analyze
```

---

## ⚙️ CI

O projeto inclui **GitHub Actions** para integração contínua:

```yaml
# .github/workflows/ci.yml
- flutter analyze
- flutter test
- flutter build apk --debug
```

> Executa automaticamente a cada commit/PR em `ubuntu-latest`

---

## 📱 Download

<p align="center">
  <a href="https://github.com/augusto49/Desafio-Mini-app-GastroGo-/releases">
    <img src="https://img.shields.io/badge/Download-APK-green?style=for-the-badge&logo=android" alt="Download APK"/>
  </a>
</p>

---

## 👨‍💻 Autor

<p align="center">
  <strong>Augusto Ferreira</strong><br>
  <a href="https://github.com/augusto49">@augusto49</a>
</p>

<p align="center">
  <em>Desafio Técnico Flutter — GastroGo (2025)</em>
</p>

---

<p align="center">
  Feito com ❤️ e ☕ usando Flutter
</p>
