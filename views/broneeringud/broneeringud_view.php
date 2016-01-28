<style>
    table, tr, td, th {
        border: 1px solid black;
        padding: 5px;
    }
</style>
<h1>Broneeringud</h1>
<table>
    <tr>
        <th>Nr</th>
        <th>Nimi</th>
        <th>Kuupäev</th>
        <th>Kellaaeg</th>
        <th>Telefoni number</th>
        <th>Email</th>
        <th>Inimeste arv</th>
    </tr>
    <?php $n = 0 ?>
    <? foreach ($broneeringud as $broneering): $n++ ?>
        <tr>
            <td id="<?= $broneering['Bron_id'] ?>"><?= $n ?></td>
            <td><?= $broneering['Bron_nimi'] ?></td>
            <td><?= $broneering['Bron_kuup'] ?></td>
            <td><?= $broneering['Bron_aeg'] ?></td>
            <td><?= $broneering['Bron_tel_nr'] ?></td>
            <td><?= $broneering['Bron_email'] ?></td>
            <td><?= $broneering['Bron_in_Arv'] ?></td>
            <td>
                <form action="broneeringud/edit/<?= $broneering['Bron_id'] ?>">
                    <div class="pull-right">
                        <button class="btn btn-primary">
                            Edit
                        </button>
                    </div>
                </form>
            </td>
        </tr>
    <? endforeach ?>
</table>
