create table Visits(
Customer_id integer not null,
City_id_visited character varying(20) NULL,
Date_visited date null
)

select * from visits v 

insert into visits(Customer_id, City_id_visited, Date_visited) values ('1001', '2003', '1-Jan-07');
insert into visits(Customer_id, City_id_visited, Date_visited) values ('1001', '2004', '1-Jan-05');
insert into visits(Customer_id, City_id_visited, Date_visited) values ('1002', '2001', '1-Jan-12');
insert into visits(Customer_id, City_id_visited, Date_visited) values ('1004', '2003', '1-Jan-13');

create table Customer(
Customer_id integer not null,
Customer_name character varying(20) NULL,
Gender char null,
Age int null
)

select * from customer c 

insert into Customer(Customer_id, Customer_name, Gender, Age) values ('1001', 'Michael', 'M', '25');
insert into Customer(Customer_id, Customer_name, Gender, Age) values ('1002', 'Winston', 'M', '40');
insert into Customer(Customer_id, Customer_name, Gender, Age) values ('1003', 'Justina', 'F', '55');
insert into Customer(Customer_id, Customer_name, Gender, Age) values ('1004', 'Jamie', 'F', '34');

create table City(
City_id integer not null,
City_name character varying(20) NULL,
Expense int null
)

select * from City


insert into City (City_id, City_name, Expense) values ('2001', 'Seattle', '500');
insert into City (City_id, City_name, Expense) values ('2002', 'NYC', '1000');
insert into City (City_id, City_name, Expense) values ('2003', 'SF', '2000');
insert into City (City_id, City_name, Expense) values ('2004', 'Miami', '800');

--1, List the cities in order of their highest visit frequency.
select count(v.city_id_visited), v.city_id_visited 
from visits v 
group by v.city_id_visited
order by count(v.city_id_visited) desc
count	city_id_visited
2	2003
1	2004
1	2001

--2, List the customers who have visited more than one city.
select v.customer_id 
from visits v 
group by (v.customer_id)
having count(*)>1 

customer_id
1001

--3, List the visit count per gender.
select c.gender, count(v.customer_id)
from customer c inner join visits v on c.customer_id = v.customer_id 
group by c.gender 

gender	count
M	3
F	1

--4, List the total expense incurred by customers on their visits every year.
select cust.customer_id, sum(c.expense), extract( year from v.date_visited) 
from visits v 
inner join city c on v.city_id_visited::int = c.city_id
left outer join customer cust on v.customer_id = cust.customer_id 
--left outer join 
group by cust.customer_id, extract( year from v.date_visited)  

customer_id	sum	date_part
1002	500		2012.0
1004	2000	2013.0
1001	800		2005.0
1001	2000	2007.0

--5, List the customer details and the city they first visited. Include the date of visit of the city as well
select * from (
select RANK() OVER ( partition by cust.customer_id order by v.date_visited ) as rankedCust, *
from customer cust
inner join visits v on v.customer_id = cust.customer_id 
inner join city c on c.city_id = v.city_id_visited::int
) a where a.rankedCust = 1

rankedcust	customer_id	customer_name	gender	age	customer_id	city_id_visited	date_visited	city_id	city_name	expense
1	1001	Michael	M	25	1001	2004	2005-01-01	2004	Miami	800
1	1002	Winston	M	40	1002	2001	2012-01-01	2001	Seattle	500
1	1004	Jamie	F	34	1004	2003	2013-01-01	2003	SF	2000




public class AgencyDutyTypeGet : SessionRequestBase, IStoredProceduresBase
{
    [OracleReturnDirection("Input")][Required][Key] public double AGEN_ID { get; set; }
    [OracleReturnDirection("InputOutput")] public double PO_RESPONSE_CD { get; set; }
    [OracleReturnDirection("InputOutput")] public string? PO_RESPONSE_TXT { get; set; }
}

public class SessionRequestBase
{
    public string PI_SESSION_APPL_CD { get; }
}
  
public interface IStoredProceduresBase
{
    public string GetStoredProcedureName();
}

public class GetById : StoredProcedure
{
    public readonly IStoredProceduresBase _model;

    public GetById(IStoredProceduresBase model) : base(model.GetStoredProcedureName())
    {
        _model = model ?? throw new ArgumentNullException(nameof(model));
    }

    public override void AddParameters(OracleDynamicParameters parameters)
    {
        var type = _model.GetType();
        var methodInfos = type.GetMethods();
        MemberInfo info = _model.GetType();
        var attributes = info.GetCustomAttributes(true);

        foreach (var method in methodInfos)
            if (method.Name.StartsWith("get_") && method.GetCustomAttribute<OracleReturnDirectionAttribute>() != null)
            {
              //do somthing here
            }
      }

var properties = type.GetProperties();

        foreach (var property in properties)
        {
            // Get custom attributes on the property
            var attributes = property.GetCustomAttributes(true);

            foreach (var attribute in attributes)
            {
                if (attribute is OracleReturnDirection returnDirectionAttribute)
                {
                    // You found the OracleReturnDirection attribute
                    string value = returnDirectionAttribute.Value;

                    // Use the value as needed
                    Console.WriteLine($"Property: {property.Name}, OracleReturnDirection: {value}");

                    // Here, you can use 'value' to set up OracleDynamicParameters
                    // based on the OracleReturnDirection value.
                }
            }
        }
