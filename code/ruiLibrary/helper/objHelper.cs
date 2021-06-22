
namespace rui
{
    /// <summary>
    /// 创建对象的辅助方法
    /// </summary>
    public class objHelper
    {
        /// <summary>
        /// 创建对象
        /// </summary>
        /// <typeparam name="T">对象类型</typeparam>
        /// <returns></returns>
        public static T newOjb<T>() where T : new()
        {
            T obj = new T();
            return obj;
        }
    }
}
