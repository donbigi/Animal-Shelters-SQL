# Animal-Shelters--SQL
## Analysis of costs to run animal shelters
<p>You are working as a data analyst in the animal welfare department. In preparation for next year's budget, the head of your department would like to know the total cost to shelter animals, broken down by each animal type and size combination (i.e., 'small dogs', 'large dogs', etc.). You need to prepare a table that contains this information.</p>
<p>The total cost to shelter an animal for the year is calculated as the sum of three factors: the size and animal type, the age, and the location.</p>
<ul>
<li>The base cost of sheltering an animal is based upon its size and type. The costs per animal type and size are contained in the <code>size_costs</code> table. The criteria for classifying size has recently been updated, and so you will need to categorize animals based upon the following table:</li>
</ul>
<table>
<thead>
<tr>
<th style="text-align:right;"></th>
<th style="text-align:right;">Small</th>
<th>Medium</th>
<th>Large</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">Dog</td>
<td style="text-align:right;">&lt;= 10 lbs</td>
<td>10 lbs &lt; and &lt;= 30 lbs</td>
<td>30 lbs &lt;</td>
</tr>
<tr>
<td style="text-align:right;">Cat</td>
<td style="text-align:right;">&lt;= 5 lbs</td>
<td>5 lbs &lt; and &lt;= 7 lbs</td>
<td>7 lbs &lt;</td>
</tr>
<tr>
<td style="text-align:right;">Bird</td>
<td style="text-align:right;">&lt;= 0.7 lbs</td>
<td>0.7 lbs &lt; and &lt;= 1.1 lbs</td>
<td>1.1 lbs &lt;</td>
</tr>
</tbody>
</table>
<ul>
<li>Older animals cost more, and so an age cost (contained in the <code>age_costs</code> table) is added. Each animal's age should be calculated as the age by the end of the year (December 31st, 2021).</li>
<li>There is a location cost depending on where the animal is sheltered (contained in the <code>location_costs</code> table). </li>
<li>The calculation should not include animals that have been sponsored by private charities (sponsored animals are listed in the <code>sponsored_animals</code> table).</li>
</ul>
<p>For future visualization purposes, you will also need to include a <code>percentage</code> column in your result. This percentage should reflect the fraction of the total cost to be allocated to each animal and size combination.</p>
<p>The data you need is available in the tables shown in the database schema below.</p>
<h5 id="databaseschema">Database Schema</h5>
<p><img src="https://assets.datacamp.com/production/repositories/5934/datasets/a946a159c0024ee0995f7a030f2c0cf802203835/diagram.PNG" width="500" height="500"> </p>