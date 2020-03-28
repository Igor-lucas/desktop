{
  "$ schema": "https://vega.github.io/schema/vega/v5.json",
  "description": "Uma pirâmide populacional que mostra dados demográficos dos EUA de 1850 a 2000.",
  "altura": 400,
  "padding": 5,

  "signs": [
    {"name": "chartWidth", "value": 300},
    {"name": "chartPad", "value": 20},
    {"name": "width", "update": "2 * chartWidth + chartPad"},
    {"nome": "ano", "valor": 2000,
      "bind": {"input": "range", "min": 1850, "max": 2000, "step": 10}}
  ],

  "dados": [
    {
      "nome": "população",
      "url": "data / população.json"
    }
    {
      "name": "popYear",
      "fonte": "população",
      "transformar": [
        {"type": "filter", "expr": "datum.year == year"}
      ]
    }
    {
      "name": "male",
      "fonte": "popYear",
      "transformar": [
        {"type": "filter", "expr": "datum.sex == 1"}
      ]
    }
    {
      "nome": "fêmeas",
      "fonte": "popYear",
      "transformar": [
        {"type": "filter", "expr": "datum.sex == 2"}
      ]
    }
    {
      "name": "ageGroups",
      "fonte": "população",
      "transformar": [
        {"type": "agregate", "groupby": ["age"]}
      ]
    }
  ],

  "escalas": [
    {
      "nome": "y",
      "type": "band",
      "range": [{"signal": "height"}, 0],
      "round": verdadeiro,
      "domain": {"data": "ageGroups", "field": "age"}
    }
    {
      "nome": "c",
      "type": "ordinal",
      "domínio": [1, 2],
      "range": ["# d5855a", "# 6c4e97"]
    }
  ],

  "marks": [
    {
      "type": "text",
      "interativo": falso,
      "from": {"data": "ageGroups"},
      "codificar": {
        "entrar": {
          "x": {"signal": "chartWidth + chartPad / 2"},
          "y": {"scale": "y", "field": "age", "band": 0,5},
          "text": {"field": "age"},
          "linha de base": {"valor": "meio"},
          "align": {"value": "center"},
          "fill": {"value": "# 000"}
        }
      }
    }
    {
      "type": "group",

      "codificar": {
        "atualização": {
          "x": {"value": 0},
          "height": {"signal": "height"}
        }
      }

      "escalas": [
        {
          "nome": "x",
          "type": "linear",
          "range": [{"signal": "chartWidth"}, 0],
          "nice": true, "zero": true,
          "domínio": {"dados": "população", "campo": "pessoas"}
        }
      ],

      "eixos": [
        {"orient": "bottom", "scale": "x", "format": "s", "title": "Mulheres"}
      ],

      "marks": [
        {
          "type": "rect",
          "from": {"data": "female"},
          "codificar": {
            "entrar": {
              "x": {"scale": "x", "field": "people"},
              "x2": {"scale": "x", "value": 0},
              "y": {"scale": "y", "field": "age"},
              "height": {"scale": "y", "band": 1, "offset": -1},
              "fillOpacity": {"value": 0.6},
              "fill": {"scale": "c", "field": "sex"}
            }
          }
        }
      ]
    }
    {
      "type": "group",

      "codificar": {
        "atualização": {
          "x": {"signal": "chartWidth + chartPad"},
          "height": {"signal": "height"}
        }
      }

      "escalas": [
        {
          "nome": "x",
          "type": "linear",
          "range": [0, {"signal": "chartWidth"}],
          "nice": true, "zero": true,
          "domínio": {"dados": "população", "campo": "pessoas"}
        }
      ],

      "eixos": [
        {"orient": "bottom", "scale": "x", "format": "s", "title": "Homens"}
      ],

      "marks": [
        {
          "type": "rect",
          "from": {"data": "male"},
          "codificar": {
            "entrar": {
              "x": {"scale": "x", "field": "people"},
              "x2": {"scale": "x", "value": 0},
              "y": {"scale": "y", "field": "age"},
              "height": {"scale": "y", "band": 1, "offset": -1},
              "fillOpacity": {"value": 0.6},
              "fill": {"scale": "c", "field": "sex"}
            }
          }
        }
      ]
    }
  ]
}
