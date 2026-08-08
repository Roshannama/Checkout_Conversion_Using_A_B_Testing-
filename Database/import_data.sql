COPY users
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\users.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);

COPY products
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\products.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);

COPY experiment_assignment
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\experiment_assignment.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);


COPY sessions
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\sessions.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);


COPY events
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\events.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);



COPY orders
FROM 'D:\complete code and devlopement\A_B_Testing\Data\raw\orders.csv'
WITH
(
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);