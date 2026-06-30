-- une commande ne peut être livrée qu'après avoir été passée, donc la date de livraison doit être supérieure à la date de commande
SELECT 
    order_id,
    ordered_at,
    delivered_to_customer_at
FROM {{ ref('fct_orders') }}
WHERE delivered_to_customer_at < ordered_at