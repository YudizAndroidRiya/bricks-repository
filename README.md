Here's a README file for your bricks repository:

---

# Bricks Repository

This repository contains reusable bricks for Flutter projects, created with the Mason CLI. These bricks are designed to streamline your development workflow by providing templates for common use cases.

## Table of Contents

- [Overview](#overview)
- [Bricks Included](#bricks-included)
- [Getting Started](#getting-started)
- [Usage](#usage)
  - [Add String Brick](#add-string-brick)
  - [Feature Brick](#feature-brick)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

This repository provides reusable templates for Flutter projects using the Mason CLI. Each brick is designed to be dynamic, allowing developers to generate files customized to their specific project structure and requirements.

---

## Bricks Included

1. **Add String Brick (`add_string`)**
   - Adds a new localization string to your project.
   - Dynamic project name support.

2. **Feature Brick (`feature`)**
   - Creates a complete feature module with `binding`, `controller`, `style`, and `widget` files.
   - Fully customizable to fit your project structure.

---

## Getting Started

### Prerequisites

1. Install [Mason CLI](https://docs.brickhub.dev/getting-started):
   ```bash
   dart pub global activate mason_cli
   ```
2. Clone this repository or reference it directly in your `mason.yaml` file.

### Cloning the Repository

To use the bricks in your project, clone this repository:

```bash
git clone https://github.com/YudizAndroidRiya/bricks-repository.git 
```

---

## Usage

Add the bricks to your project by updating your `mason.yaml` file. You can either use a relative path (if the repository is cloned locally) or the Git URL.

### Example `mason.yaml`:

#### Using Relative Path
```yaml
bricks:
  add_string:
    path: ./bricks/add_string
  feature:
    path: ./bricks/feature
```

#### Using Git URL
```yaml
bricks:
  add_string:
    git:
      url: https://github.com/YudizAndroidRiya/bricks-repository.git
      path: add_string
  feature:
    git:
      url: https://github.com/YudizAndroidRiya/bricks-repository.git
      path: feature
```

### Running the Bricks

#### Add String Brick
Generate a localization string with the `add_string` brick:
```bash
mason make add_string --keyValue="hello:Hello World" --project_name=my_project
```

#### Feature Brick
Generate a feature module with the `feature` brick:
```bash
mason make feature --name=my_feature --project_name=my_project
```

---

## Contributing

Contributions are welcome! If you'd like to contribute to this repository, please follow these steps:

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m 'Add your feature'`).
4. Push the branch (`git push origin feature/your-feature`).
5. Create a Pull Request.

---

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
