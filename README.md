# Olist Analytics dbt Project

![dbt](https://img.shields.io/badge/dbt-Fusion-orange)
![Snowflake](https://img.shields.io/badge/Snowflake-Data%20Warehouse-blue)
![AWS S3](https://img.shields.io/badge/AWS%20S3-Data%20Ingestion-yellow)
![SQL](https://img.shields.io/badge/SQL-Analytics-lightgrey)
![Analytics Engineering](https://img.shields.io/badge/Analytics%20Engineering-Portfolio-success)

## Présentation

Ce projet construit un entrepôt analytique e-commerce à partir des données brutes du marketplace brésilien Olist.

Les données sources sont stockées dans un bucket Amazon S3, puis ingérées dans Snowflake dans un schéma `RAW` avant d’être transformées avec dbt en modèles analytiques propres, testés et exploitables.

L’objectif est de transformer des données opérationnelles brutes en modèles fiables pour l’analyse business : commandes, clients, vendeurs, produits, paiements, avis, performance de livraison, taux de change et chiffre d’affaires en BRL/EUR.

Le projet suit les bonnes pratiques d’Analytics Engineering avec dbt, Snowflake, une architecture en couches, des modèles SQL modulaires, des macros réutilisables et des tests de qualité automatisés.

## Sommaire

- [Contexte Business](#contexte-business)
- [Stack Technique](#stack-technique)
- [Architecture](#architecture)
- [Ingestion des Données](#ingestion-des-données)
- [Modèle de Données](#modèle-de-données)
- [Questions Business](#questions-business)
- [Macros](#macros)
- [Stratégie de Tests](#stratégie-de-tests)
- [Résultats de Validation](#résultats-de-validation)
- [Insights Business](#insights-business)
- [Lancer le Projet Localement](#lancer-le-projet-localement)
- [Structure du Projet](#structure-du-projet)
- [Apprentissages](#apprentissages)
- [Améliorations Futures](#améliorations-futures)

## Contexte Business

Olist est une marketplace brésilienne qui connecte des vendeurs à des clients à travers le Brésil.

Ce projet simule un pipeline Analytics Engineering réaliste pour une entreprise e-commerce. Les données brutes sont chargées depuis un bucket S3 vers Snowflake, puis transformées en tables analytiques fiables permettant de suivre :

- la performance des commandes ;
- le comportement client ;
- la contribution des vendeurs ;
- la performance des catégories produits ;
- les délais de livraison ;
- les moyens de paiement ;
- les scores d’avis ;
- le chiffre d’affaires en BRL et en EUR.

## Stack Technique

- Amazon S3 pour le stockage des fichiers sources
- Snowflake pour le data warehouse
- dbt Fusion pour la transformation SQL
- SQL pour la modélisation analytique
- dbt tests pour la qualité de données
- dbt macros pour la logique réutilisable
- Modélisation dimensionnelle
- Bonnes pratiques Analytics Engineering

## Architecture

```mermaid
flowchart LR
    A[Amazon S3 Bucket] --> B[Snowflake RAW Schema]
    B --> C[dbt Staging Models]
    C --> D[dbt Intermediate Models]
    D --> E[Analytics Marts]
    E --> F[Business Analysis / BI]

## Ingestion des Données

Les fichiers sources du dataset Olist sont stockés dans un bucket Amazon S3. Snowflake charge ces fichiers dans le schéma RAW à l’aide d’un stage externe et de commandes COPY INTO.
Le schéma RAW contient les tables brutes suivantes :
OLIST_ORDERS
OLIST_CUSTOMERS
OLIST_ORDER_ITEMS
OLIST_ORDER_PAYMENTS
OLIST_ORDER_REVIEWS
OLIST_PRODUCTS
OLIST_SELLERS
OLIST_GEOLOCATION
OLIST_CHANGE

## Résultats de Validation

![dbt run](image.png)

![dbt test](image-1.png)




