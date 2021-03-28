# Joy API Reference

{{#each .}}

**{{name}}**

{{#each functions~}}
[{{name}}](#{{name}}){{#unless @last}} | {{/unless}}
{{~/each}}

{{/each}}

{{#each .}}

## {{name}}

{{#each functions}}

### {{name}}

_{{name}} {{arguments}} &rarr; {{returns}}_

{{description}}

{{/each}}

{{/each}}
