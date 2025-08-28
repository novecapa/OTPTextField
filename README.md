# 🔐 VerificationField (SwiftUI)

Un componente ligero y elegante en **SwiftUI** para introducir códigos de verificación (OTP / One-Time Code).  
Ideal para login con SMS, verificación de email o 2FA.

---

## ✨ Características

- ✅ **Longitud configurable** (4, 6 dígitos, etc.)
- ✅ **Estilos personalizables**: borde redondeado o subrayado
- ✅ **Validación asíncrona** con callback
- ✅ **Autorrelleno de iOS** (`.oneTimeCode`)
- ✅ **Soporte de pegar y backspace**
- ✅ Hecho 100% en SwiftUI

---

## 📦 Requisitos

- iOS **15.0+**  
- Swift **5.7+**  
- Xcode **14+**

---

## 🚀 Instalación

### Swift Package Manager

1. En Xcode: **File > Add Packages…**  
2. Introduce la URL del repo:

   ```bash
   https://github.com/<tu-usuario>/VerificationField
   ```

3. Selecciona la versión y añádela a tu target.

---

## 🧑‍💻 Uso

### Ejemplo básico

```swift
import SwiftUI

struct ContentView: View {
    @State private var code: String = ""

    var body: some View {
        VerificationField(type: .six, style: .roundedBorder, value: $code) { result in
            if result.count < 6 {
                return .typing
            } else if result == "123456" {
                return .valid
            } else {
                return .invalid
            }
        }
    }
}
```

### Parámetros

- **type** → longitud del código (`.four` o `.six`)
- **style** → estilo visual (`.roundedBorder`, `.underlined`)
- **value** → binding del string que guarda el código
- **onChange** → callback asíncrono que devuelve el estado (`.typing`, `.valid`, `.invalid`)

---

## 🎨 Estilos disponibles

```swift
enum TextFieldStyle: String, CaseIterable {
    case roundedBorder = "Rounded Border"
    case underlined = "Underlined"
}
```

---

## 📸 Demo

WIP
---

## 📄 Licencia

MIT © [Josep Cerdá Penadés]
