-- +micrate Up
CREATE TABLE games (
  id UUID PRIMARY KEY,
  type VARCHAR,
  name VARCHAR,
  data VARCHAR,
  hashed_password VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS games;
