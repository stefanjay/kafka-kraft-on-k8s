{{/* Define template to generate controller.quorum.voters for broker mode */}}
{{- define "kafka.controllerQuorumVoters" -}}
{{- $totalReplicas := .Values.kafka.configmap.properties.controllerReplicas -}}
{{- $service := .Values.kafka.configmap.properties.controllerService -}}
{{- $namespace := .Values.kafka.configmap.properties.namespace -}}
{{- $voters := list -}}
{{- range $i := until (int $totalReplicas) }}
  {{- $voter := printf "%d@controller-%d.%s.%s.svc:9093" $i $i $service $namespace -}}
  {{- $voters = append $voters $voter -}}
{{- end }}
{{- join "," $voters -}}
{{- end -}}

{{/* Define template to generate controller.quorum.voters for combined broker and controller mode */}}
{{- define "kafka.controllerQuorumVotersCombined" -}}
{{- $totalReplicas := .Values.kafka.configmap.properties.brokerReplicas -}}
{{- $service := .Values.kafka.configmap.properties.service -}}
{{- $namespace := .Values.kafka.configmap.properties.namespace -}}
{{- $voters := list -}}
{{- range $i := until (int $totalReplicas) }}
  {{- $voter := printf "%d@kafka-%d.%s.%s.svc:9093" $i $i $service $namespace -}}
  {{- $voters = append $voters $voter -}}
{{- end }}
{{- join "," $voters -}}
{{- end -}}