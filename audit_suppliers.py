import sqlite3
import pandas as pd

conn = None

try:
    conn = sqlite3.connect('karoo_agriculture.db')
    cur = conn.cursor()

    risk_query = '''
    SELECT DISTINCT supplier_id
    FROM v_supplier_health
    WHERE
        cert_status IN ('Expired', 'Expiring Soon')
        OR orders_90d = 0
        OR latest_yield < (rolling_avg_yield * 0.8)
    '''

    risk_df = pd.read_sql_query(risk_query, conn)

    at_risk_ids = risk_df['supplier_id'].tolist()

    update_query = '''
    UPDATE suppliers
    SET status = ?
    WHERE supplier_id = ?
    '''

    cur.executemany(
        update_query,
        [('Review', supplier_id) for supplier_id in at_risk_ids]
    )

    conn.commit()

    print(f'\n{len(at_risk_ids)} suppliers require review.')

except sqlite3.Error as e:
    if conn:
        conn.rollback()

    print(f'Database error: {e}')

except Exception as e:
    if conn:
        conn.rollback()

    print(f'Unexpected error: {e}')

finally:
    if conn:
        conn.close()

    print('Database connection closed.')