key functions:

1.

    /* function that computes state transition as induced by a
     * normalized ADL action. Adds go before deletes!
     *
     * a bit odd in implementation:
     * function returns number of new goal that came in when applying
     * op to source; needed for Goal Added Deletion Heuristic
     */
    int result_to_dest( State *dest, State *source, int op )

2.
    
    void source_to_dest( State *dest, State *source )

    {

      int i;

      for ( i = 0; i < source->num_F; i++ ) {
        dest->F[i] = source->F[i];
      }
      dest->num_F = source->num_F;

    }

3.
    void print_op_name( int index )

    {

      int i;
      Action *a = gop_conn[index].action;

      if ( !a->norm_operator &&
           !a->pseudo_action ) {
        printf("REACH-GOAL");
      } else {
        printf("%s", a->name ); 
        for ( i = 0; i < a->num_name_vars; i++ ) {
          printf(" %s", gconstants[a->name_inst_table[i]]);
        }
      }

    }
