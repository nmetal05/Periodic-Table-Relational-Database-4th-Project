
#!/bin/bash


if [ $# -eq 0 ];then
  echo "Please provide an element as an argument."
else
# Search for the element in the database
  element_data=$(psql --username=freecodecamp --dbname=periodic_table -tAc "select e.*,t.type,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius from elements as e join properties as p on e.atomic_number=p.atomic_number join types as t on p.type_id = t.type_id WHERE e.atomic_number::text = '$1' OR e.symbol = '$1' OR e.name = '$1' ")
   # Check if the element was found
  if [ -z "$element_data" ]; then
    echo "I could not find that element in the database."
  else
  # Extract and print element information
  atomic_number=$(echo "$element_data" | cut -d'|' -f1)
  symbol=$(echo "$element_data" | cut -d'|' -f2)
  name=$(echo "$element_data" | cut -d'|' -f3)
  type=$(echo "$element_data" | cut -d'|' -f4)
  mass=$(echo "$element_data" | cut -d'|' -f5)
  melting_point=$(echo "$element_data" | cut -d'|' -f6)
  boiling_point=$(echo "$element_data" | cut -d'|' -f7)

  echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
  fi

fi
