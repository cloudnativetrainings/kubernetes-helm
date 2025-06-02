# slides

## add go templating slides

## helm test slides - shouldn't it be a job instead of a pod?

## Slides deps

- no dep resolution shown
- problem with values from dep chart

## Kostumize slides... re-order... there are elements which is not only for kostumize

## Scoping

https://docs.google.com/presentation/d/1w-0nXHO5iCmBfWv--TdQoda_BH1b7eVCzI_zeIE5TlU/edit#slide=id.g184bfc764f3_1_114
=> field "repository" does not exist in values.yaml

## explain dots in slides

```helm
{{- include "labels" . | nindent 8 }}
```

=> When you see {{- include "labels" . }}, the dot (.) is being passed as an argument to the "labels" template. This means the "labels" template will have access to the same values and context as the place where it was called. This is important for reusing templates and ensuring they have the necessary data to render correctly.
