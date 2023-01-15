
# Corona Tone Mapping Wrapper 
**for 3ds Max Script** (Maxscript)

Hello all, this is a wrapper `(Tone Mapping Pipeline Wrapper.ms)` for new Corona Renderer 8 (and upper versions) tone mapping for maxscrip which is a not easy to work with. So, here is my 3ds Max scrip codes to make it easier for others to use this new feature.



[![version](https://img.shields.io/badge/version-1.0-blue)](https://mohseni.info/bio/) 

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/mohseni-mr/Corona-Tone-Mapping-Wrapper/blob/main/LICENSE)

[![Corona Version](https://img.shields.io/badge/Corona%20Renderer-v8.0%20and%20up-red)](https://corona-renderer.com/)
## 👨🏻‍💻 Author

- [@mohseni-mr](https://github.com/mohseni-mr)
if you want to get in touch with me through other platforms please, use below link
[![social landing page and website](https://img.shields.io/badge/my_social_langind_page-FF0000?style=for-the-badge)](https://mohseni.info/bio/)
## Features

- Delete all tone mapping operators
- Get all tone mapping operators and their IDs as an array
- Get the IDs of all tone mapping operators
- Get all tone mapping operators
- Generate a unique random ID that does not exist in the current operators' list
- Get operators' class using its place on tone mapping list
- Get operators' using its place on tone mapping list
- Specify whether the operators' list is empty or not (true or false)
- Delete last operator
- Add operator as last one
- Add operator to a specific place on the list
- Delete operator to a specific place on the list
## Function Reference

you can use this wrapper pretty easily. 

It is kind of make array of operators and work around that to make things nicer and cleaner.

| Function | Description |
| ----------------- | ----------------- |
| `ClearAllTMOperators` | Delete all tone mapping operators |
| `GetAllTMOperatorsPlusIDs` | Get all tone mapping operators and their IDs as an array |
| `GetAllTMOperatorsIDs` | Get the IDs of all tone mapping operators |
| `GetAllTMOperators` | Get all tone mapping operators |
| `GenerateID` | Generate a unique random ID that does not exist in the current operators' list |
| `GetTMOperatorsClass` | Get operators' class using its place on tone mapping list |
| `GetTMOperators` | Get operators' using its place on tone mapping list |
| `IsTMEmpy` | Specify whether the operators' list is empty or not (true or false) |
| `DelLastTMOperators` | Delete last operator |
| `AddTMOperatorsLast` | Add operator as last one |
| `AddTMOperatorsOnSpot` | Add operator to a specific place on the list |
| `DelTMOperatorsOnSpot` | Delete operator to a specific place on the list |

## Usage/Examples

```
- Add a Contrast operator to the end of list
crnToneMapping.AddTMOperatorsLast #(ContrastOperatorPlugin colorMappingOperator_contrast:2.00)

- Delete last operator
crnToneMapping.DelLastTMOperators()

- Add a contrast and AcesOt operator to a specific place (5) on the list and also change their parameters
crnToneMapping.AddTMOperatorsOnSpot #(ContrastOperatorPlugin colorMappingOperator_contrast:0.6, AcesOtOperatorPlugin colorMappingOperator_opacity:0.4) id:5
```


## Feedback

If you have any feedback, please reach out to me through my email:
mohamad.r.mohseni@gmail.com

or just comment on Corona Renderer forums:
[![Forums](https://img.shields.io/badge/-Topic%20on%20Corona%20Renderer%20Forums-orange)](https://forum.corona-renderer.com/index.php?topic=37407.0)



## API Reference

#### Get all items

```http
  GET /api/items
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get item

```http
  GET /api/items/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch |

#### add(num1, num2)

Takes two numbers and returns the sum.


## Acknowledgement



 - [official Corona Renderer maxscript wiki page](https://wiki.corona-renderer.com/maxscript)
