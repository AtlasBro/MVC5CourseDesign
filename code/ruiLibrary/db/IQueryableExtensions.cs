using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;

namespace rui
{

    /// <summary>
    /// IEnumerable查询在内存中进行，获取到所有数据，并进行查询. 对应于Linq to Object
    /// 而IQueryable查询时生成对应的Sql语句，在数据库中进行查询. 对应于Linq to Sql
    /// </summary>
    public static class IQueryableExtensions
    {
        /// <summary>
        /// EntiryFramework动态查询结果分页,查询中需要有orderby语句
        /// </summary>
        public static IQueryable<T> ToPagedQuery<T>(this IQueryable<T> query, int pageSize, int pageNumber)
        {
            return query.Skip(pageSize * (pageNumber - 1)).Take(pageSize);
        }

        /// <summary>
        /// EntiryFramework动态查询结果转为DataTable
        /// </summary>
        public static DataTable ToDataTable<T>(this IQueryable<T> enumerable)
        {
            DataTable dataTable = new DataTable();
            //生成表头
            foreach (PropertyDescriptor pd in TypeDescriptor.GetProperties(typeof(T)))
            {
                dataTable.Columns.Add(pd.Name, pd.PropertyType);
            }
            //填充数据
            foreach (T item in enumerable)
            {
                var Row = dataTable.NewRow();

                foreach (PropertyDescriptor pd in TypeDescriptor.GetProperties(typeof(T)))
                {
                    Row[pd.Name] = pd.GetValue(item);
                }
                dataTable.Rows.Add(Row);
            }
            return dataTable;
        }

        /// <summary>
        /// 内存对象查询结果分页
        /// </summary>
        public static IEnumerable<T> ToPagedQuery<T>(this IEnumerable<T> query, int pageSize, int pageNumber)
        {
            return query.Skip(pageSize * (pageNumber - 1)).Take(pageSize);
        }

        /// <summary>
        /// 查询结果转为DataTable
        /// </summary>
        public static DataTable ToDataTable<T>(this IEnumerable<T> enumerable)
        {
            DataTable dataTable = new DataTable();
            foreach (PropertyDescriptor pd in TypeDescriptor.GetProperties(typeof(T)))
            {
                dataTable.Columns.Add(pd.Name, pd.PropertyType);
            }
            foreach (T item in enumerable)
            {
                var Row = dataTable.NewRow();

                foreach (PropertyDescriptor pd in TypeDescriptor.GetProperties(typeof(T)))
                {
                    Row[pd.Name] = pd.GetValue(item);
                }
                dataTable.Rows.Add(Row);
            }
            return dataTable;
        }
    }
}
