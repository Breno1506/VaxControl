# 🌡️ VaxControl

**Monitoramento inteligente da cadeia de frio para preservação de vacinas e imunobiológicos.**

---

## 📌 Sobre o Projeto

O **VaxControl** é uma solução de **Internet das Coisas (IoT)** desenvolvida para resolver um problema crítico na área da saúde pública e privada: **a perda e o descarte de vacinas devido à degradação térmica**.

Muitos imunobiológicos exigem armazenamento rigoroso em faixas térmicas estreitas (geralmente entre **+2°C e +8°C**). Falhas no sistema elétrico, portas de câmaras frias mal fechadas ou avarias em termostatos podem comprometer lotes inteiros em poucas horas, gerando prejuízos financeiros milionários e desabastecimento de vacinas essenciais.

O **VaxControl** realiza a leitura e monitoramento contínuo da temperatura e umidade em tempo real, enviando alertas preventivos antes que os medicamentos atinjam temperaturas críticas de perda.

---

## 🎯 Principais Objetivos

- **Aquisição de Dados em Tempo Real:** Captura contínua de parâmetros ambientais via sensores conectados ao Arduino.
- **Persistência Segura:** Registro estruturado das medições em banco de dados relacional (MySQL).
- **Visualização Analítica:** Dashboard web interativo com gráficos de variação de temperatura e métricas históricas.
- **Alertas Preventivos:** Notificação ágil para equipes responsáveis ao detectar desvios de temperatura.
- **Calculadora:** Simulador financeiro integrado para evidenciar a economia de custos com a prevenção de perdas.

---

## 📐 Arquitetura da Solução

  [ Câmera Fria / Geladeira ]
               │
               ▼
   [ Sensor de Temperatura ]
               │
               ▼
       [ Placa Arduino ]
               │
               ▼  
     [ Banco de Dados MySQL ]
               │
               ▼ 
  [ Dashboard Web / VaxControl ]  ──────► [ Alertas & Gráficos ]
